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
