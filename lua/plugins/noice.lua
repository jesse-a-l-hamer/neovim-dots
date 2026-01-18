return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  ---@module 'noice'
  ---@type NoiceConfig
  opts = {
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
  },
}
