local accent_color = "flamingo"

---@module 'lazy'
---@module 'catppuccin'
return { ---@type LazyPluginSpec
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme "catppuccin"
  end,
  ---@type CatppuccinOptions
  opts = {
    background = {
      light = "latte",
      dark = "macchiato",
    },
    show_end_of_buffer = true,
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15,
    },
    default_integrations = false,
    auto_integrations = true,
    lsp_styles = {
      virtual_text = {
        errors = { "bold", "italic" },
        hints = { "bold", "italic" },
        warnings = { "bold", "italic" },
        information = { "bold", "italic" },
        ok = { "bold", "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
        ok = { "undercurl" },
      },
      inlay_hints = {
        background = true,
      },
    },
    custom_highlights = function(colors)
      return { ---@type table<string, CtpHighlight>
        -- globals
        CursorLineNr = { fg = colors[accent_color] },
        FloatBorder = { fg = colors[accent_color] },
        Title = { fg = colors[accent_color] },
        BlinkCmpMenuBorder = { fg = colors[accent_color] },
        BlinkCmpDocBorder = { fg = colors[accent_color] },
        BlinkCmpSignatureHelpBorder = { fg = colors[accent_color] },
      }
    end,
    integrations = {
      blink_cmp = {
        enabled = true,
        style = "bordered",
      },
      colorful_winsep = {
        enabled = true,
        color = accent_color,
      },
      diffview = true,
      flash = true,
      lsp_trouble = true,
      noice = true,
      nvim_surround = true,
      render_markdown = true,
      snacks = { enabled = true, indent_scope_color = accent_color },
      telescope = { enabled = false },
      which_key = true,
    },
  },
}
