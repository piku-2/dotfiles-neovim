-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- terminal mode で jj を押したら Normal mode に戻る
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminalmode" })
-- 通常の Inser mode を jj で抜ける
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
