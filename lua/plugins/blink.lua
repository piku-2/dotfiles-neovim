return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion = opts.completion or {}
      opts.completion.ghost_text = { enabled = false }
      opts.completion.documentation = opts.completion.documentation or {}
      -- 候補を選んでいる最中にドキュメントが被さらないよう、少し待つ。
      opts.completion.documentation.auto_show_delay_ms = 500

      opts.keymap = opts.keymap or {}
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function(cmp)
          if cmp.is_visible() then
            return cmp.accept()
          end
        end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
    end,
  },
}
