---@module 'lazy'

---@type LazyPluginSpec
return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  ---@module 'colorizer'
  opts = {
    user_default_options = { names = false },
  },
}
