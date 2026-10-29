# nvim

書く専用。プラグインなし。`init.lua` と配色の `colors/catppuccin-mocha-lite.lua` だけで動く。マシンごとの分岐は無い。反映は、このリポジトリで `git pull` する。

- Neovim 0.7 以上で起動する。`smoothscroll` は、そのオプションがあるとき（0.10 以降）だけ有効になる
- インデントの既定はタブ、幅 4。`.py` はスペース 4。`.editorconfig` に `indent_style` があるバッファは、その指定が先に立つ。使う言語が増えたら、その言語の設定を足す
- 長い行は折り返す。カウントなしの `j` / `k` は、オペレータ待ちも含めて画面上の行を移動する
- 挿入モードとターミナルモードは `jj` で抜ける
- ヤンクとペーストはシステムクリップボード
- ファイルは引数か `:e` で開く
- 同梱パーサがある言語だけ treesitter で色が付く。無ければ標準の syntax
- ステータスラインは出さない。`nvim .` や `:e` でディレクトリを開くと、同梱の netrw が一覧を出す

## 配色

Catppuccin Mocha 風。ダーク専用。

- 背景は既定で透過。塗りつぶすときは colorscheme より前に `vim.g.catppuccin_lite_transparent = false`
- `termguicolors` は有効にする

