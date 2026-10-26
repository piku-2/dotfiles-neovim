-- Autocmds are automatically loaded on the VeryLazy event
local group = vim.api.nvim_create_augroup("nvim_config", { clear = true })

-- 保存時の整形は conform。LSP の format は使わない。
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

-- blink のメニュー中は Copilot のゴーストテキストを隠す
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
