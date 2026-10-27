-- LazyVim の既定のあとで読む。ここには差分だけ。

-- 補完は LSP だけ。Copilot は extra もプラグインも載せない。
vim.g.snacks_animate = false
vim.lsp.log.set_level("OFF")
vim.g.lazyvim_python_lsp = "basedpyright"

-- 選択は Ghostty の copy-on-select。
vim.opt.mouse = ""
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 8

-- プロジェクトの .editorconfig と formatter がこの初期値より先に立つ。
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- 複合Key入力の判定待ち時間を短縮
vim.opt.timeoutlen = 300

-- 新規作成ファイルのデフォルト改行コードを LF に指定
vim.opt.fileformat = "unix"

-- ファイル保存・読み込み時の改行コード候補（unix=LF を優先）
vim.opt.fileformats = { "unix", "dos" }
