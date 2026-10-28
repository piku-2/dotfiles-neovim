-- lua/plugins/disable.lua
return {
  -- 1. LSP / フォーマッタ / 補完 / AI 関連を一括ブロック
  { "neovim/nvim-lspconfig", enabled = false },
  { "saghen/blink.cmp", enabled = false },
  { "hrsh7th/nvim-cmp", enabled = false },
  { "stevearc/conform.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },

  -- 2. お節介系 UI / 自動介入を一括ブロック
  { "folke/noice.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.animate", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
}
