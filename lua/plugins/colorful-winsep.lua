---@module 'lazy'

---@type LazyPluginSpec
return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  opts = {
    highlight = function() end,
  },
}
