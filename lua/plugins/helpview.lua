---@module "lazy"
---@module "helpview"

---@type LazyPluginSpec
return {
  "OXY2DEV/helpview.nvim",
  lazy = false,
  ---@type helpview.config
  opts = {
    preview = {
      icon_provider = "devicons",
    },
  },
}
