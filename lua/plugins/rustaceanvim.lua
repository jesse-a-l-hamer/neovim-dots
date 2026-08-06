---@module 'lazy'

---@type LazyPluginSpec
return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false, -- plugin implements its own lazy-loading; no need to use lazy.nvim
  config = function(opts)
    vim.g.rustaceanvim = {
      tools = {
        test_executor = "background",
      },
    }
  end,
}
