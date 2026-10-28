# nvim

プラグインなし。`init.lua` と配色の `colors/catppuccin-mocha-lite.lua` だけで動く。

- Neovim 0.10 以上が要る（`smoothscroll` などを使う）。Ubuntu 24.04 の apt 版（0.9.5）では動かない
- インデントはタブ、幅 4
- 長い行は折り返す。カウントなしの `j` / `k` は画面上の行を移動する
- 挿入モードとターミナルモードは `jj` で抜ける
- Space `f` で、今のディレクトリ以下のファイル名を部分一致で開く。候補が複数なら `vim.ui.select` で選ぶ。20 件、またはディレクトリ 2000 個で打ち切って通知する。`.git`、`.cache`、`node_modules`、`target`、`dist` の中は探さない
- 同梱パーサがある言語だけ treesitter で色が付く。無ければ標準の syntax

## 配色

Catppuccin Mocha 風。ダーク専用。

- 背景は既定で透過。塗りつぶすときは colorscheme より前に `vim.g.catppuccin_lite_transparent = false`
- `termguicolors` は設定せず、Neovim の自動判定に任せる

## SSH 先で Ghostty から使う

リモートに `xterm-ghostty` の terminfo が要る。手元から送る:

```sh
infocmp -x xterm-ghostty | ssh <host> -- tic -x -
```

Ghostty 1.2 以上なら、`shell-integration-features` に `ssh-terminfo,ssh-env` を足しても入る。
