-- ~/.config/nvim/lua/plugins/minimal.lua
return {
	-- =========================================
	-- 1. LSP / 補完 / AI 機能を完全に無効化
	-- =========================================
	-- LSP（言語サーバー本体）をオフ
	{ "neovim/nvim-lspconfig", enabled = false },
	-- 補完エンジン（blink.cmp または nvim-cmp）をオフ
	{ "saghen/blink.cmp", enabled = false },
	{ "hrsh7th/nvim-cmp", enabled = false },
	-- Formatter / Linter をオフ
	{ "stevearc/conform.nvim", enabled = false },
	{ "mfussenegger/nvim-lint", enabled = false },
	-- Copilot や AI 関連の連携をオフ
	{ "zbirenbaum/copilot.lua", enabled = false },
}
