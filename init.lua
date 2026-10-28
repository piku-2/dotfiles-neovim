-- プラグインなし。入っている Neovim だけで動く。

-- 連携機能を読み込まないようにする。
for _, provider in ipairs({ "python3", "ruby", "perl", "node" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- vim.options は Lua で書くときの推奨方法。vim.o は古い書き方。
vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.number = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.smoothscroll = true
vim.opt.scrolloff = 4
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 0

-- 配色: Catppuccin Mocha 風（colors/catppuccin-mocha-lite.lua）
vim.opt.cursorline = true
vim.cmd.colorscheme("catppuccin-mocha-lite")

vim.keymap.set("i", "jj", "<Esc>", { desc = "jj でノーマルモードへ" })
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "jj でターミナルノーマルモードへ" })
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, desc = "カウントなしなら表示行で下へ" })
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, desc = "カウントなしなら表示行で上へ" })

-- open_file で中に入らないディレクトリ（同名のファイルは対象のまま）
local skip_dir = {
  [".git"] = true,
  [".cache"] = true,
  ["node_modules"] = true,
  ["target"] = true,
  ["dist"] = true,
}

-- cwd 以下のファイルを名前で開く。<leader>f に割り当て。
local function open_file()
  local query = vim.fn.input({ prompt = "file: ", cancelreturn = "" })
  if query == "" then
    return
  end
  local needle = query:lower()
  local root = vim.fn.getcwd()
  local hits = {}
  local limit = 20
  local max_dirs = 2000
  local dirs = 1 -- root の分
  local dir_capped = false

  -- depth = 9: root 直下を 1 段目として、旧実装（depth 0..8 のディレクトリを走査）と同じ深さ
  local iter = vim.fs.dir(root, {
    depth = 9,
    skip = function(d)
      if skip_dir[vim.fs.basename(d)] then
        return false
      end
      if dirs >= max_dirs then
        dir_capped = true
        return false
      end
      dirs = dirs + 1
      return true
    end,
  })
  for rel, typ in iter do
    local path = vim.fs.joinpath(root, rel)
    if typ == "link" or typ == nil then
      -- シンボリックリンクはリンク先の種類で判定する
      typ = (vim.uv.fs_stat(path) or {}).type
    end
    if typ == "file" and vim.fs.basename(rel):lower():find(needle, 1, true) then
      hits[#hits + 1] = path
      if #hits >= limit then
        vim.notify(("open_file: %d 件で打ち切り"):format(limit), vim.log.levels.WARN)
        break
      end
    end
  end
  if dir_capped and #hits < limit then
    vim.notify(("open_file: ディレクトリ %d 個で走査を打ち切り"):format(max_dirs), vim.log.levels.WARN)
  end

  local function edit(path)
    if not path then
      return
    end
    -- % や # などを展開させずにそのまま開く
    local ok, err = pcall(vim.cmd.edit, { args = { path }, magic = { file = false } })
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end

  if #hits == 0 then
    vim.notify("no match: " .. query, vim.log.levels.WARN)
    return
  end
  if #hits == 1 then
    edit(hits[1])
    return
  end

  table.sort(hits)
  vim.ui.select(hits, {
    prompt = "open:",
    format_item = function(path)
      return vim.fn.fnamemodify(path, ":.")
    end,
  }, edit)
end

vim.keymap.set("n", "<leader>f", open_file, { desc = "cwd 以下のファイルを名前で開く" })
