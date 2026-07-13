---@module 'lazy'

---@type LazyPluginSpec
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "lewis6991/async.nvim",
  },
  lazy = false,
  keys = {
    {
      "<leader>lR",
      function()
        require("refactoring").select_refactor()
      end,
      mode = { "n", "x" },
      desc = "Refactor",
    },
  },
  opts = {},
}
