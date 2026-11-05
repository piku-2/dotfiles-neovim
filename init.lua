-- プラグインなし。入っている Neovim だけで動く。

-- 外部言語のプロバイダは使わない。ディレクトリ一覧は同梱の netrw に任せる。
for _, provider in ipairs({ "python3", "ruby", "perl", "node" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.number = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.smoothscroll = true
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

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

vim.opt.path:append("**")
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*/.git/*", "*/node_modules/*", "*/__pycache__/*", "*.o" })

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.updatetime = 200
vim.opt.showmode = false
vim.opt.virtualedit = "block"

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "検索ハイライトを消す" })

-- netrw
vim.g.netrw_banner = 0

-- 改行時に自動でコメントが継続するのを防ぐ
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

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

-- ヤンクした部分をハイライト
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("yank_highlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

-- 最後に開いたカーソル位置の復元
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
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
