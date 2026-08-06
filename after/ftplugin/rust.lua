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

vim.keymap.set("n", "<leader>lt", function()
  vim.cmd.RustLsp { "relatedTests" }
end, { silent = true, buffer = bufnr, desc = "Find related tests" })

vim.keymap.set("n", "<leader>lT", function()
  vim.cmd.RustLsp { "testables" }
end, { silent = true, buffer = bufnr, desc = "Show testables" })

vim.keymap.set("n", "<leader>lc", function()
  vim.cmd.RustLsp { "openCargo" }
end, { silent = true, buffer = bufnr, desc = "Open Cargo.toml" })

require("which-key").add { "<leader>dR", group = "Rustaceanvim" }
vim.keymap.set("n", "<leader>dRd", function()
  vim.cmd.RustLsp { "debug" }
end, { silent = true, buffer = bufnr, desc = "Debug at cursor" })
vim.keymap.set("n", "<leader>dRD", function()
  vim.cmd.RustLsp { "debuggables" }
end, { silent = true, buffer = bufnr, desc = "See all debuggables" })

-- OPTIONS
vim.o.colorcolumn = "100"

-- NEOTEST
require("neotest").setup {
  adapters = {
    require "rustaceanvim.neotest",
  },
}

-- RUSTACEANVIM CONFIG
---@type rustaceanvim.Config
