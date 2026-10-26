return {
  {
    "zbirenbaum/copilot.lua",
    -- extra の build は :Copilot auth で、対話が要る。ここでは走らせない。
    build = false,
    opts = {
      panel = { enabled = false },
      nes = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        python = true,
        c = true,
        cpp = true,
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        lua = true,
        markdown = false,
        help = false,
        ["*"] = false,
      },
    },
  },
}
