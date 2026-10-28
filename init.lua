-- プラグインなし。入っている Neovim だけで動く。

-- 連携機能を読み込まないようにする。ディレクトリを開いてもファイラは出さない。
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
for _, provider in ipairs({ "python3", "ruby", "perl", "node" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.number = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
-- 0.10 未満にはこのオプションが無く、代入すると init 全体が止まる。
if vim.fn.exists("+smoothscroll") == 1 then
	vim.opt.smoothscroll = true
end
vim.opt.scrolloff = 4
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300

-- .editorconfig の indent_style があるバッファは、そちらのままにする。
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("python_indent", { clear = true }),
	pattern = "python",
	callback = function(ev)
		local applied = vim.b[ev.buf].editorconfig
		if type(applied) == "table" and applied.indent_style then
			return
		end
		vim.bo[ev.buf].expandtab = true
		vim.bo[ev.buf].tabstop = 4
		vim.bo[ev.buf].shiftwidth = 4
		vim.bo[ev.buf].softtabstop = 4
	end,
})

-- 配色: Catppuccin Mocha 風（colors/catppuccin-mocha-lite.lua）
vim.opt.cursorline = true
vim.cmd.colorscheme("catppuccin-mocha-lite")

vim.keymap.set("i", "jj", "<Esc>", { desc = "jj でノーマルモードへ" })
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "jj でターミナルノーマルモードへ" })
vim.keymap.set({ "n", "x", "o" }, "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, desc = "カウントなしなら表示行で下へ" })
vim.keymap.set({ "n", "x", "o" }, "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, desc = "カウントなしなら表示行で上へ" })

-- open_file で中に入らないディレクトリ（同名のファイルは対象のまま）
local skip_dir = {
	[".git"] = true,
	[".cache"] = true,
	["node_modules"] = true,
	["target"] = true,
	["dist"] = true,
}

local uv = vim.uv or vim.loop

local function edit_path(path)
	if not path then
		return
	end
	-- % や # などを展開させずにそのまま開く
	local ok, err
	if vim.fn.has("nvim-0.10") == 1 then
		ok, err = pcall(vim.cmd.edit, { args = { path }, magic = { file = false } })
	else
		ok, err = pcall(vim.cmd, "edit " .. vim.fn.fnameescape(path))
	end
	if not ok then
		vim.notify(err, vim.log.levels.ERROR)
	end
end

-- depth を持たない vim.fs.dir と同じ上限で幅優先に探す。
local function search_files_legacy(root, needle)
	local hits = {}
	local limit = 20
	local max_dirs = 2000
	local dir_count = 1 -- root の分
	local dir_capped = false
	local hit_capped = false
	local queue = { { rel = "", level = 1 } }
	local head = 1

	local function base_name(path)
		return path:match("([^/]+)$") or path
	end

	local function join_path(dir, name)
		if dir == "" then
			return name
		end
		if dir:sub(-1) == "/" then
			return dir .. name
		end
		return dir .. "/" .. name
	end

	while head <= #queue do
		local item = queue[head]
		head = head + 1
		local dirpath = item.rel == "" and root or join_path(root, item.rel)
		local fs = uv.fs_scandir(dirpath)
		if fs then
			while true do
				local name, typ = uv.fs_scandir_next(fs)
				if not name then
					break
				end
				local rel = item.rel == "" and name or join_path(item.rel, name)
				local path = join_path(root, rel)
				local kind = typ
				if kind == "link" or kind == nil then
					kind = (uv.fs_stat(path) or {}).type
				end
				if kind == "file" and base_name(rel):lower():find(needle, 1, true) then
					hits[#hits + 1] = path
					if #hits >= limit then
						hit_capped = true
						return hits, dir_capped, hit_capped
					end
				end
				-- シンボリックリンクの先がディレクトリでも降りない（follow なしと同じ）
				if typ == "directory" and item.level < 9 then
					if not skip_dir[base_name(rel)] then
						if dir_count >= max_dirs then
							dir_capped = true
						else
							dir_count = dir_count + 1
							queue[#queue + 1] = { rel = rel, level = item.level + 1 }
						end
					end
				end
			end
		end
	end
	return hits, dir_capped, hit_capped
end

local function search_files(root, needle)
	if vim.fn.has("nvim-0.10") ~= 1 or vim.fs == nil or vim.fs.dir == nil then
		return search_files_legacy(root, needle)
	end

	local hits = {}
	local limit = 20
	local max_dirs = 2000
	local dirs = 1 -- root の分
	local dir_capped = false
	local hit_capped = false

	-- depth = 9: root 直下を 1 段目として、旧実装（depth 0..8 のディレクトリを走査）と同じ深さ
	local iter = vim.fs.dir(root, {
		depth = 9,
		skip = function(d)
			if skip_dir[vim.fs.basename(d)] then
				return false
			end
			if dirs >= max_dirs then
				dir_capped = true
				return false
			end
			dirs = dirs + 1
			return true
		end,
	})
	for rel, typ in iter do
		local path = vim.fs.joinpath(root, rel)
		if typ == "link" or typ == nil then
			-- シンボリックリンクはリンク先の種類で判定する
			typ = (uv.fs_stat(path) or {}).type
		end
		if typ == "file" and vim.fs.basename(rel):lower():find(needle, 1, true) then
			hits[#hits + 1] = path
			if #hits >= limit then
				hit_capped = true
				vim.notify(("open_file: %d 件で打ち切り"):format(limit), vim.log.levels.WARN)
				break
			end
		end
	end
	return hits, dir_capped, hit_capped
end

-- cwd 以下のファイルを名前で開く。<leader>f に割り当て。
local function open_file()
	local query = vim.fn.input({ prompt = "file: ", cancelreturn = "" })
	if query == "" then
		return
	end
	local needle = query:lower()
	local root = vim.fn.getcwd()
	local hits, dir_capped, hit_capped = search_files(root, needle)
	local limit = 20
	local max_dirs = 2000
	if hit_capped and vim.fn.has("nvim-0.10") ~= 1 then
		vim.notify(("open_file: %d 件で打ち切り"):format(limit), vim.log.levels.WARN)
	end
	if dir_capped and #hits < limit then
		vim.notify(
			("open_file: ディレクトリ %d 個で走査を打ち切り"):format(max_dirs),
			vim.log.levels.WARN
		)
	end

	if #hits == 0 then
		vim.notify("no match: " .. query, vim.log.levels.WARN)
		return
	end
	if #hits == 1 then
		edit_path(hits[1])
		return
	end

	table.sort(hits)
	vim.ui.select(hits, {
		prompt = "open:",
		format_item = function(path)
			return vim.fn.fnamemodify(path, ":.")
		end,
	}, edit_path)
end

vim.keymap.set("n", "<leader>f", open_file, { desc = "cwd 以下のファイルを名前で開く" })
