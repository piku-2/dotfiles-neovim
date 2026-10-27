local bin = require("config.system").bin

local function mason_bin(name)
  local path = vim.fn.stdpath("data") .. "/mason/bin/" .. name
  if vim.fn.executable(path) == 1 then
    return path
  end
  return name
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }

      -- 編集中の行には仮想テキストを出さない。ヒントは Trouble / gl に残す。
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        update_in_insert = false,
        virtual_text = {
          current_line = false,
          severity = { min = vim.diagnostic.severity.WARN },
        },
        signs = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
        underline = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
      })

      opts.servers = opts.servers or {}

      -- システム clangd。索引は低優先度。補完で #include は挿さない。
      local clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
        mason = false,
        init_options = {
          usePlaceholders = true,
          completeUnimported = false,
          clangdFileStatus = false,
        },
      })
      clangd.cmd = {
        bin("clangd"),
        "--background-index",
        "--background-index-priority=low",
        "--clang-tidy",
        "--header-insertion=never",
        "--header-insertion-decorators=0",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=none",
        "--all-scopes-completion",
        "--limit-results=40",
        "--pch-storage=memory",
        "--malloc-trim",
        "--log=error",
      }
      opts.servers.clangd = clangd

      opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
        mason = false,
        cmd = { bin("ruff"), "server" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
      })

      -- 型・定義・補完は basedpyright。import 整理と整形は ruff。
      -- 開いているファイルだけ解析する。プロジェクト全体は保存のたびに走らせない。
      opts.servers.basedpyright = vim.tbl_deep_extend("force", opts.servers.basedpyright or {}, {
        mason = true,
        cmd = { mason_bin("basedpyright-langserver"), "--stdio" },
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              typeCheckingMode = "standard",
              diagnosticMode = "openFilesOnly",
              autoSearchPaths = true,
              autoImportCompletions = true,
              inlayHints = {
                callArgumentNames = false,
                functionReturnTypes = false,
                variableTypes = false,
              },
            },
          },
        },
      })
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      options = {
        notify_user_on_venv_activation = false,
      },
    },
  },
}
