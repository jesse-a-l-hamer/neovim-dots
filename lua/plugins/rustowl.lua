---@module 'lazy'
---@module 'catppuccin'

local palette = require("catppuccin.palettes").get_palette()

---@type LazyPluginSpec
return {
  "cordx56/rustowl",
  version = "*", -- Latest stable version
  build = "cargo install rustowl",
  lazy = false, -- This plugin is already lazy
  opts = {
    client = {
      on_attach = function(_, buffer)
        vim.keymap.set("n", "<leader>lo", function()
          require("rustowl").toggle(buffer)
        end, { buffer = buffer, desc = "Toggle RustOwl" })
      end,
    },
    colors = {
      lifetime = palette.green,
      imm_borrow = palette.sapphire,
      mut_borrow = palette.mauve,
      move = palette.yellow,
      call = palette.peach,
      outlive = palette.red,
    },
    highlight_style = {
      definitely_live = "underline",
      maybe_initialized = "undercurl",
    },
  },
}
