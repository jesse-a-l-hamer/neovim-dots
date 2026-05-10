local accent_color = "flamingo"

---@module 'lazy'
---@module 'catppuccin'

---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme "catppuccin-nvim"
  end,
  ---@type CatppuccinOptions
  opts = {
    background = {
      light = "latte",
      dark = "macchiato",
    },
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15,
    },
    transparent_background = true,
    float = { transparent = true },
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
      ---@type table<string, CtpHighlight>
      return {
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
      blink_cmp = { style = "bordered" },
      colorful_winsep = { color = accent_color },
      snacks = { indent_scope_color = accent_color },
    },
  },
}
