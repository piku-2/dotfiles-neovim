local bin = require("config.system").bin

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        clangd = {
          mason = false,
          cmd = {
            bin("clangd"),
            "--background-index",
            "--clang-tidy",
            -- iwyu inserts includes that were not typed. none skips LLVM's
            -- space indent when a directory has no .clang-format.
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=none",
          },
        },
        ruff = {
          mason = false,
          cmd = { bin("ruff"), "server" },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },
      },
    },
  },
}
