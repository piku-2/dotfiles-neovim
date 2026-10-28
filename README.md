# nvim

書く専用。プラグインなし。`init.lua` と配色の `colors/catppuccin-mocha-lite.lua` だけで動く。マシンごとの分岐は無い。反映は、このリポジトリで `git pull` する。

- Neovim 0.7 以上で起動する。`smoothscroll` は、そのオプションがあるとき（0.10 以降）だけ有効になる
- インデントの既定はタブ、幅 4。`.py` はスペース 4。`.editorconfig` に `indent_style` があるバッファは、その指定が先に立つ
- 長い行は折り返す。カウントなしの `j` / `k` は、オペレータ待ちも含めて画面上の行を移動する
- 挿入モードとターミナルモードは `jj` で抜ける
- Space `f` で、今のディレクトリ以下のファイル名を部分一致で開く。候補が複数なら `vim.ui.select` で選ぶ。20 件、またはディレクトリ 2000 個で打ち切って通知する。`.git`、`.cache`、`node_modules`、`target`、`dist` の中は探さない。0.10 未満でも同じ上限で探す
- 同梱パーサがある言語だけ treesitter で色が付く。無ければ標準の syntax
- ステータスラインは出さない。ディレクトリを開いてもファイラは出さない

## 配色

Catppuccin Mocha 風。ダーク専用。

- 背景は既定で透過。塗りつぶすときは colorscheme より前に `vim.g.catppuccin_lite_transparent = false`
- `termguicolors` は有効にする

## SSH 先で Ghostty から使う

リモートに `xterm-ghostty` の terminfo が要る。手元から送る:

```sh
infocmp -x xterm-ghostty | ssh <host> -- tic -x -
```

Ghostty 1.2 以上なら、`shell-integration-features` に `ssh-terminfo,ssh-env` を足しても入る。
