return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local bin = require("config.system").bin
      opts.default_format_opts = vim.tbl_deep_extend("force", opts.default_format_opts or {}, {
        lsp_format = "never",
      })
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "ruff_organize_imports", "ruff_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
      })
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        prettier = { require_cwd = true },
        -- LLVM の fallback はスペースインデントで、ftplugin のタブと保存のたびに喧嘩する。
        ["clang-format"] = {
          command = bin("clang-format"),
          condition = function(_, ctx)
            return vim.fs.find({ ".clang-format", "_clang-format" }, { path = ctx.filename, upward = true })[1]
              ~= nil
          end,
        },
        ruff_format = { command = bin("ruff") },
        ruff_organize_imports = { command = bin("ruff") },
        -- stylua.toml が無い Lua（Hyprland など）は触らない。
        stylua = {
          condition = function(_, ctx)
            return vim.fs.find({ "stylua.toml", ".stylua.toml" }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
      })
    end,
  },
}
