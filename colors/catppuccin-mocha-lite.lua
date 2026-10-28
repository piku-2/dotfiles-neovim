-- Catppuccin Mocha 風（プラグインなし、自前のハイライト）
-- 値は catppuccin/nvim の Mocha パレットと既定ハイライトに合わせている。
-- Neovim の既定リンクで同じ色になるグループは定義しない
-- （Number, Float, Boolean, Keyword, Repeat, Exception, Define, PreCondit,
--   StorageClass, Structure, Typedef, SpecialChar, SpecialComment, Debug,
--   Underlined, VisualNOS, CursorIM, PmenuMatchSel, LspCodeLens,
--   LspReferenceRead/Write, @string.special/escape/regexp,
--   @function.call/method, @keyword.function/return/operator,
--   @punctuation.bracket/delimiter など）。
--
-- 背景は既定で透過（bg = NONE）。Ghostty の background-opacity や Wallust 向け。
-- 塗りつぶしたいときは colorscheme より前に:
--   vim.g.catppuccin_lite_transparent = false

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "catppuccin-mocha-lite"

local c = {
  rosewater = "#f5e0dc", flamingo = "#f2cdcd", pink = "#f5c2e7", mauve = "#cba6f7",
  red = "#f38ba8", maroon = "#eba0ac", peach = "#fab387", yellow = "#f9e2af",
  green = "#a6e3a1", teal = "#94e2d5", sky = "#89dceb", sapphire = "#74c7ec",
  blue = "#89b4fa", lavender = "#b4befe", text = "#cdd6f4", subtext1 = "#bac2de",
  subtext0 = "#a6adc8", overlay2 = "#9399b2", overlay1 = "#7f849c", overlay0 = "#6c7086",
  surface2 = "#585b70", surface1 = "#45475a", surface0 = "#313244",
  base = "#1e1e2e", mantle = "#181825", crust = "#11111b",
}

local transparent = vim.g.catppuccin_lite_transparent ~= false
-- エディタ本体の背景
local bg = transparent and "NONE" or c.base

-- U.darken(color, alpha, base) で base と混ぜた色（upstream と同じ値）
local cursorline = "#2a2b3c" -- surface0, 0.64
local surface1_dim = "#393b4d" -- surface1, 0.70

local hl = {
  -- editor
  Normal = { fg = c.text, bg = bg },
  SignColumn = { fg = c.surface1, bg = bg },
  FoldColumn = { fg = c.overlay0, bg = bg },
  EndOfBuffer = { fg = c.surface1, bg = bg },
  LineNr = { fg = c.surface1 },
  CursorLineNr = { fg = c.lavender },
  NormalFloat = { fg = c.text, bg = c.mantle },
  FloatBorder = { fg = c.blue, bg = c.mantle },
  FloatTitle = { fg = c.subtext0, bg = c.mantle },
  FloatShadow = { bg = c.overlay0, blend = 80 },
  FloatShadowThrough = { bg = c.overlay0, blend = 100 },
  Cursor = { fg = c.base, bg = c.rosewater },
  lCursor = { fg = c.base, bg = c.rosewater },
  TermCursor = { fg = c.base, bg = c.rosewater },
  CursorLine = { bg = cursorline },
  CursorColumn = { bg = c.mantle },
  ColorColumn = { bg = c.surface0 },
  Conceal = { fg = c.overlay1 },
  Folded = { fg = c.blue, bg = c.surface1 },
  WinSeparator = { fg = c.crust },
  MsgSeparator = { link = "WinSeparator" },
  StatusLine = { fg = c.text, bg = c.mantle },
  StatusLineNC = { fg = c.surface1, bg = c.mantle },
  TabLine = { fg = c.overlay0, bg = c.crust },
  TabLineSel = { link = "Normal" },
  TabLineFill = { bg = c.mantle },
  WinBar = { fg = c.rosewater },
  WinBarNC = { link = "WinBar" },
  Pmenu = { fg = c.overlay2, bg = c.mantle },
  PmenuSel = { fg = c.text, bg = c.surface0, bold = true },
  PmenuKind = { fg = c.blue, bg = c.mantle },
  PmenuKindSel = { fg = c.blue, bg = c.surface0, bold = true },
  PmenuExtra = { fg = c.overlay0 },
  PmenuExtraSel = { fg = c.overlay0, bg = c.surface0, bold = true },
  PmenuMatch = { fg = c.text, bold = true },
  PmenuSbar = { bg = c.surface0 },
  PmenuThumb = { bg = c.overlay0 },
  PreInsert = { fg = c.overlay2 },
  ComplMatchIns = { link = "PreInsert" },
  Visual = { bg = c.surface1, bold = true },
  Search = { fg = c.text, bg = "#3e5767" }, -- sky, 0.30
  IncSearch = { fg = c.mantle, bg = "#7ec9d8" }, -- sky, 0.90
  CurSearch = { fg = c.mantle, bg = c.red },
  Substitute = { fg = c.pink, bg = c.surface1 },
  MatchParen = { fg = c.peach, bg = surface1_dim, bold = true },
  NonText = { fg = c.overlay0 },
  Whitespace = { fg = c.surface1 },
  SpecialKey = { link = "NonText" },
  Directory = { fg = c.blue },
  Title = { fg = c.blue, bold = true },
  Question = { fg = c.blue },
  MoreMsg = { fg = c.blue },
  ModeMsg = { fg = c.text, bold = true },
  ErrorMsg = { fg = c.red, bold = true, italic = true },
  WarningMsg = { fg = c.yellow },
  OkMsg = { fg = c.green },
  WildMenu = { bg = c.overlay0 },
  QuickFixLine = { bg = surface1_dim, bold = true },
  SpellBad = { sp = c.red, undercurl = true },
  SpellCap = { sp = c.yellow, undercurl = true },
  SpellLocal = { sp = c.blue, undercurl = true },
  SpellRare = { sp = c.green, undercurl = true },

  -- syntax
  Comment = { fg = c.overlay2, italic = true },
  Constant = { fg = c.peach },
  String = { fg = c.green },
  Character = { fg = c.teal },
  Identifier = { fg = c.flamingo },
  Function = { fg = c.blue },
  Statement = { fg = c.mauve },
  Conditional = { fg = c.mauve, italic = true },
  Label = { fg = c.sapphire },
  Operator = { fg = c.sky },
  PreProc = { fg = c.pink },
  Include = { fg = c.mauve },
  Macro = { fg = c.mauve },
  Type = { fg = c.yellow },
  Special = { fg = c.pink },
  Tag = { fg = c.lavender, bold = true },
  Delimiter = { fg = c.overlay2 },
  Error = { fg = c.red },
  Todo = { fg = c.base, bg = c.flamingo, bold = true },
  qfLineNr = { fg = c.yellow },
  qfFileName = { fg = c.blue },

  -- treesitter
  ["@variable"] = { fg = c.text },
  ["@variable.builtin"] = { fg = c.red },
  ["@variable.parameter"] = { fg = c.maroon },
  ["@variable.member"] = { fg = c.lavender },
  ["@property"] = { fg = c.lavender },
  ["@constant.builtin"] = { fg = c.peach },
  ["@module"] = { fg = c.yellow, italic = true },
  ["@attribute"] = { link = "Constant" },
  ["@function.builtin"] = { fg = c.peach },
  ["@constructor"] = { fg = c.yellow },
  ["@keyword.conditional"] = { link = "Conditional" },
  ["@type.builtin"] = { fg = c.mauve },
  ["@comment.error"] = { fg = c.base, bg = c.red },
  ["@comment.warning"] = { fg = c.base, bg = c.yellow },
  ["@comment.todo"] = { fg = c.base, bg = c.flamingo },
  ["@comment.note"] = { fg = c.base, bg = c.blue },
  ["@tag"] = { fg = c.blue },
  ["@tag.attribute"] = { fg = c.yellow, italic = true },
  ["@markup.strong"] = { fg = c.red, bold = true },
  ["@markup.italic"] = { fg = c.red, italic = true },
  ["@markup.heading"] = { fg = c.blue },
  ["@markup.link.url"] = { fg = c.blue, italic = true, underline = true },
  ["@markup.raw"] = { fg = c.green },

  -- LSP
  LspReferenceText = { bg = c.surface1 },
  LspSignatureActiveParameter = { bg = c.surface0, bold = true },
  LspInlayHint = { fg = c.overlay0, bg = transparent and "NONE" or cursorline },
  ["@lsp.type.enumMember"] = { fg = c.teal },
  ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },

  -- diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.sky },
  DiagnosticHint = { fg = c.teal },
  DiagnosticOk = { fg = c.green },
  DiagnosticVirtualTextError = { fg = c.red, bg = "#32283a", italic = true },
  DiagnosticVirtualTextWarn = { fg = c.yellow, bg = "#33313a", italic = true },
  DiagnosticVirtualTextInfo = { fg = c.sky, bg = "#283040", italic = true },
  DiagnosticVirtualTextHint = { fg = c.teal, bg = "#29313e", italic = true },
  DiagnosticVirtualTextOk = { fg = c.green, bg = "#29313e", italic = true },
  DiagnosticUnderlineError = { sp = c.red, underline = true },
  DiagnosticUnderlineWarn = { sp = c.yellow, underline = true },
  DiagnosticUnderlineInfo = { sp = c.sky, underline = true },
  DiagnosticUnderlineHint = { sp = c.teal, underline = true },
  DiagnosticUnderlineOk = { sp = c.green, underline = true },

  -- diff
  DiffAdd = { bg = "#364143" }, -- green, 0.18
  DiffChange = { bg = "#25293c" }, -- blue, 0.07
  DiffDelete = { bg = "#443244" }, -- red, 0.18
  DiffText = { bg = "#3e4b6b" }, -- blue, 0.30
  Added = { fg = c.green },
  Changed = { fg = c.blue },
  Removed = { fg = c.red },
  diffAdded = { fg = c.green },
  diffRemoved = { fg = c.red },
  diffChanged = { fg = c.blue },
}

for group, spec in pairs(hl) do
  vim.api.nvim_set_hl(0, group, spec)
end

-- ダーク専用。:set background=light されると Neovim はこの配色を外す
-- （colors_name を消す）ので、その直後に読み直してダークに戻す。
-- 別の colorscheme に切り替えたら何もしない。
local group = vim.api.nvim_create_augroup("catppuccin_mocha_lite", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
  group = group,
  pattern = "background",
  callback = function()
    if vim.o.background ~= "dark" and vim.g.colors_name == nil then
      vim.cmd.colorscheme("catppuccin-mocha-lite")
    end
  end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function(args)
    if args.match ~= "catppuccin-mocha-lite" then
      vim.api.nvim_del_augroup_by_id(group)
    end
  end,
})
