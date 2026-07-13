local bufnr = vim.api.nvim_get_current_buf()

-- KEYMAPS
vim.keymap.set("n", "<leader>lA", function()
  vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr, desc = "Code actions (grouped)" })

vim.keymap.set("n", "<leader>lh", function()
  vim.cmd.RustLsp { "hover", "actions" }
end, { silent = true, buffer = bufnr, desc = "Hover actions" })

vim.keymap.set("n", "<leader>le", function()
  vim.cmd.RustLsp { "explainError", "current" }
end, { silent = true, buffer = bufnr, desc = "Explain errors" })

vim.keymap.set("n", "<leader>lR", function()
  vim.cmd.RustLsp { "renderDiagnostic", "current" }
end, { silent = true, buffer = bufnr, desc = "Render diagnostic" })

-- OPTIONS
vim.o.colorcolumn = "100"
