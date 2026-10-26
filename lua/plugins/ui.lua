return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      -- basedpyright は編集のたびに title が空の $/progress を送る。
      -- タイトルがある進捗（clangd の索引など）はそのまま出す。
      opts.routes = opts.routes or {}
      table.insert(opts.routes, 1, {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local progress = message.opts and message.opts.progress
            local title = progress and progress.title
            return title == nil or title == ""
          end,
        },
        opts = { skip = true },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- Ghostty は半透明なので、コード面は透かさない。
      style = "night",
      transparent = false,
    },
  },
}
