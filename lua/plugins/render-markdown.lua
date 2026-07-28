---@module 'lazy'

---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = true,
    on = {},
    debounce = 50,
    file_types = { "markdown", "blink-cmp-documentation", "codecompanion" },
    completions = { lsp = { enabled = true }, blink = { enabled = true } },
    heading = {
      width = "block",
      min_width = 30,
    },
    pipe_table = { preset = "round", border_virtual = true, cell = "trimmed" },
    dash = { width = 88 },
    code = {
      language_border = " ",
      language_left = "",
      language_right = "",
      width = "block",
      min_width = 44,
    },
    latex = {
      enabled = true,
      -- comment/uncoment the following line to enable/disable latex rendering
      -- converter = {},
    },
    quote = { repeat_linebreak = true },
    win_options = {
      showbreak = {
        default = "",
        rendered = "  ",
      },
      breakindent = {
        default = false,
        rendered = true,
      },
      breakindentopt = {
        default = "",
        rendered = "",
      },
    },
  },
}
