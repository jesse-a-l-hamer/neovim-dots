local rust_adapter = require "rustaceanvim.neotest"

local python_adapter = require "neotest-python" {
  dap = { justMyCode = false },
  args = { "--log-level", "DEBUG" },
  runner = "pytest",
}

require("neotest").setup {
  adapters = {
    rust_adapter,
    python_adapter,
  },
}
