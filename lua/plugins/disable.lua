-- lua/plugins/enable.lua
-- 【ホワイトリスト方式】
-- LazyVimの全拡張モジュール（LSP, 補完, UI演出, 自動介入）をルートで拒否し、
-- 本当に必要な「見た目と骨格」だけをピンポイントで有効化する

return {
  -- =========================================================================
  -- 1. デフォルトの過剰機能を一括無効化（全OFF）
  -- =========================================================================
  -- UI演出・ポップアップ割り込み
  { "folke/noice.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "echasnovski/mini.animate", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- 入力自動介入・補完・LSP・診断
  { "echasnovski/mini.pairs", enabled = false },
  { "neovim/nvim-lspconfig", enabled = false },
  { "saghen/blink.cmp", enabled = false },
  { "hrsh7th/nvim-cmp", enabled = false },
  { "stevearc/conform.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },

  -- =========================================================================
  -- 2. 本当に必要なものだけを明示的に有効化（ホワイトリスト）
  -- =========================================================================
  -- 見た目をイケてるLazyVim仕様にするカラースキーム
  {
    "folke/tokyonight.nvim",
    enabled = true,
    opts = { style = "storm" },
  },

  -- 爆速で綺麗な構文ハイライト
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
  },

  -- 下部のステータスライン（見た目のモダンさ維持）
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
  },

  -- 必要最小限のファイル検索（Telescope）
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
  },
}
