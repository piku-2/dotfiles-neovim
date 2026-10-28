-- プラグインなし。入っている Neovim だけで動く。

for _, provider in ipairs({ "python3", "ruby", "perl", "node" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

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

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("t", "jj", [[<C-\><C-n>]])
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

local skip_dir = {
  [".git"] = true,
  [".cache"] = true,
  ["node_modules"] = true,
  ["target"] = true,
  ["dist"] = true,
}

local function open_file()
  local query = vim.fn.input("file: ")
  if query == "" then
    return
  end
  local needle = query:lower()
  local root = vim.uv.cwd() or vim.fn.getcwd()
  local hits = {}
  local limit = 20
  local dirs = 0

  local function scan(dir, depth)
    if #hits >= limit or depth > 8 or dirs > 2000 then
      return
    end
    local fd = vim.uv.fs_scandir(dir)
    if not fd then
      return
    end
    dirs = dirs + 1
    while #hits < limit do
      local name, typ = vim.uv.fs_scandir_next(fd)
      if not name then
        break
      end
      if not skip_dir[name] then
        local path = dir .. "/" .. name
        if not typ then
          local st = vim.uv.fs_stat(path)
          typ = st and st.type
        end
        if typ == "directory" then
          scan(path, depth + 1)
        elseif typ == "file" and name:lower():find(needle, 1, true) then
          hits[#hits + 1] = path
        end
      end
    end
  end

  scan(root, 0)

  if #hits == 0 then
    vim.notify("no match: " .. query)
    return
  end
  if #hits == 1 then
    vim.cmd.edit(hits[1])
    return
  end

  local items = {}
  for i, path in ipairs(hits) do
    items[i] = i .. ": " .. vim.fn.fnamemodify(path, ":.")
  end
  local choice = vim.fn.inputlist(items)
  if hits[choice] then
    vim.cmd.edit(hits[choice])
  end
end

vim.keymap.set("n", "<leader>f", open_file)
