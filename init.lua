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

-- 配色: Catppuccin Mocha 風（プラグインなし、自前のハイライト）
vim.opt.termguicolors = true
vim.opt.cursorline = true

local c = {
  rosewater = "#f5e0dc", flamingo = "#f2cdcd", pink = "#f5c2e7", mauve = "#cba6f7",
  red = "#f38ba8", maroon = "#eba0ac", peach = "#fab387", yellow = "#f9e2af",
  green = "#a6e3a1", teal = "#94e2d5", sky = "#89dceb", sapphire = "#74c7ec",
  blue = "#89b4fa", lavender = "#b4befe", text = "#cdd6f4", subtext1 = "#bac2de",
  subtext0 = "#a6adc8", overlay2 = "#9399b2", overlay1 = "#7f849c", overlay0 = "#6c7086",
  surface2 = "#585b70", surface1 = "#45475a", surface0 = "#313244",
  base = "#1e1e2e", mantle = "#181825", crust = "#11111b",
}

local function apply_catppuccin()
  vim.cmd("highlight clear")
  vim.o.background = "dark"
  vim.g.colors_name = "catppuccin-mocha-lite"

  local hl = {
    Normal = { fg = c.text, bg = c.base },
    NormalNC = { fg = c.text, bg = c.base },
    NormalFloat = { fg = c.text, bg = c.mantle },
    FloatBorder = { fg = c.blue, bg = c.mantle },
    FloatTitle = { fg = c.subtext0, bg = c.mantle },
    Cursor = { fg = c.base, bg = c.rosewater },
    CursorLine = { bg = c.surface0 },
    CursorColumn = { bg = c.mantle },
    ColorColumn = { bg = c.surface0 },
    LineNr = { fg = c.surface1 },
    CursorLineNr = { fg = c.lavender, bold = true },
    SignColumn = { fg = c.surface1, bg = c.base },
    FoldColumn = { fg = c.overlay0, bg = c.base },
    Folded = { fg = c.blue, bg = c.surface1 },
    VertSplit = { fg = c.crust },
    WinSeparator = { fg = c.crust },
    StatusLine = { fg = c.text, bg = c.mantle },
    StatusLineNC = { fg = c.surface1, bg = c.mantle },
    TabLine = { fg = c.overlay0, bg = c.mantle },
    TabLineSel = { fg = c.text, bg = c.base, bold = true },
    TabLineFill = { bg = c.mantle },
    WinBar = { fg = c.rosewater },
    Pmenu = { fg = c.overlay2, bg = c.mantle },
    PmenuSel = { fg = c.text, bg = c.surface0, bold = true },
    PmenuSbar = { bg = c.surface0 },
    PmenuThumb = { bg = c.overlay0 },
    Visual = { bg = c.surface1, bold = true },
    VisualNOS = { bg = c.surface1, bold = true },
    Search = { fg = c.text, bg = "#3e5767" },
    IncSearch = { fg = c.crust, bg = c.pink },
    CurSearch = { fg = c.crust, bg = c.red },
    Substitute = { fg = c.crust, bg = c.pink },
    MatchParen = { fg = c.peach, bg = c.surface1, bold = true },
    NonText = { fg = c.overlay0 },
    Whitespace = { fg = c.surface1 },
    SpecialKey = { fg = c.overlay0 },
    EndOfBuffer = { fg = c.base },
    Directory = { fg = c.blue },
    Title = { fg = c.blue, bold = true },
    Question = { fg = c.blue },
    MoreMsg = { fg = c.blue },
    ModeMsg = { fg = c.text, bold = true },
    ErrorMsg = { fg = c.red, bold = true },
    WarningMsg = { fg = c.yellow },
    WildMenu = { bg = c.overlay0 },
    QuickFixLine = { bg = c.surface1, bold = true },
    SpellBad = { sp = c.red, undercurl = true },
    SpellCap = { sp = c.yellow, undercurl = true },
    SpellLocal = { sp = c.blue, undercurl = true },
    SpellRare = { sp = c.green, undercurl = true },

    Comment = { fg = c.overlay2, italic = true },
    Constant = { fg = c.peach },
    String = { fg = c.green },
    Character = { fg = c.teal },
    Number = { fg = c.peach },
    Float = { fg = c.peach },
    Boolean = { fg = c.peach },
    Identifier = { fg = c.flamingo },
    Function = { fg = c.blue },
    Statement = { fg = c.mauve },
    Conditional = { fg = c.mauve },
    Repeat = { fg = c.mauve },
    Label = { fg = c.sapphire },
    Operator = { fg = c.sky },
    Keyword = { fg = c.mauve },
    Exception = { fg = c.mauve },
    PreProc = { fg = c.pink },
    Include = { fg = c.mauve },
    Define = { fg = c.pink },
    Macro = { fg = c.mauve },
    Type = { fg = c.yellow },
    StorageClass = { fg = c.yellow },
    Structure = { fg = c.yellow },
    Typedef = { fg = c.yellow },
    Special = { fg = c.pink },
    SpecialChar = { fg = c.pink },
    Delimiter = { fg = c.overlay2 },
    SpecialComment = { fg = c.overlay1, italic = true },
    Underlined = { underline = true },
    Error = { fg = c.red },
    Todo = { fg = c.base, bg = c.yellow, bold = true },

    ["@variable"] = { fg = c.text },
    ["@variable.builtin"] = { fg = c.red },
    ["@variable.parameter"] = { fg = c.maroon },
    ["@variable.member"] = { fg = c.lavender },
    ["@property"] = { fg = c.lavender },
    ["@constant.builtin"] = { fg = c.peach },
    ["@function.builtin"] = { fg = c.peach },
    ["@function.call"] = { fg = c.blue },
    ["@function.method"] = { fg = c.blue },
    ["@constructor"] = { fg = c.sapphire },
    ["@keyword.function"] = { fg = c.mauve },
    ["@keyword.return"] = { fg = c.mauve },
    ["@keyword.operator"] = { fg = c.mauve },
    ["@type.builtin"] = { fg = c.mauve },
    ["@module"] = { fg = c.lavender, italic = true },
    ["@punctuation.bracket"] = { fg = c.overlay2 },
    ["@punctuation.delimiter"] = { fg = c.overlay2 },
    ["@string.escape"] = { fg = c.pink },
    ["@string.regexp"] = { fg = c.pink },
    ["@tag"] = { fg = c.mauve },
    ["@tag.attribute"] = { fg = c.teal, italic = true },
    ["@markup.heading"] = { fg = c.blue, bold = true },
    ["@markup.link.url"] = { fg = c.rosewater, underline = true },
    ["@markup.raw"] = { fg = c.teal },

    DiagnosticError = { fg = c.red },
    DiagnosticWarn = { fg = c.yellow },
    DiagnosticInfo = { fg = c.sky },
    DiagnosticHint = { fg = c.teal },
    DiagnosticOk = { fg = c.green },
    DiagnosticUnderlineError = { sp = c.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.sky, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
    DiagnosticVirtualTextError = { fg = c.red, bg = "#2d2032" },
    DiagnosticVirtualTextWarn = { fg = c.yellow, bg = "#2f2c35" },
    DiagnosticVirtualTextInfo = { fg = c.sky, bg = "#222c3a" },
    DiagnosticVirtualTextHint = { fg = c.teal, bg = "#232d35" },

    DiffAdd = { bg = "#2c3b3a" },
    DiffChange = { bg = "#25293c" },
    DiffDelete = { bg = "#3a2a37" },
    DiffText = { bg = "#3a4058" },
    Added = { fg = c.green },
    Changed = { fg = c.blue },
    Removed = { fg = c.red },
  }

  for group, spec in pairs(hl) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  local term = {
    c.surface1, c.red, c.green, c.yellow, c.blue, c.pink, c.teal, c.subtext1,
    c.surface2, c.red, c.green, c.yellow, c.blue, c.pink, c.teal, c.subtext0,
  }
  for i, color in ipairs(term) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

apply_catppuccin()

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
