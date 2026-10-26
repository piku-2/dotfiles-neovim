-- Keymaps are automatically loaded on the VeryLazy event
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- terminal mode で jj を押したら Normal mode に戻る
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminalmode" })

-- 通常の Inser mode を jj で抜ける
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
