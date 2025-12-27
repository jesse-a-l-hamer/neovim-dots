return { ---@type LazyPluginSpec
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  opts = {
    highlight = function() end,
  },
}
