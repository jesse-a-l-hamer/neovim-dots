local colors = require("catppuccin.palettes").get_palette "macchiato"
local noice_api_status = require "noice.api.status"

---@module 'lazy'

---@type LazyPluginSpec[]
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/noice.nvim" },
    opts = {
      options = {
        theme = "catppuccin-nvim",
        globalstatus = true,
        always_divide_middle = true,
      },
      extensions = {
        "lazy",
        "man",
        "nvim-dap-ui",
        "trouble",
      },
      sections = {
        lualine_b = {
          "branch",
          "diff",
          "tabs",
          "windows",
        },
        lualine_c = { "filetype", "lsp_status", "diagnostics" },
        lualine_x = {
          {
            noice_api_status.message.get_hl,
            cond = noice_api_status.message.has,
          },
          {
            noice_api_status.command.get,
            cond = noice_api_status.command.has,
            color = { fg = colors.peach },
          },
          {
            noice_api_status.mode.get,
            cond = noice_api_status.mode.has,
            color = { fg = colors.peach },
          },
          {
            noice_api_status.search.get,
            cond = noice_api_status.search.has,
            color = { fg = colors.peach },
          },
        },
        lualine_y = {
          "encoding",
          "fileformat",

          "progress",
          "location",
          "vim.api.nvim_buf_line_count(0)",
        },
        lualine_z = {
          { "datetime", style = "%H:%M" },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/trouble.nvim", "folke/snacks.nvim" },
    opts = function(_, opts)
      local trouble = require "trouble"
      local symbols = trouble.statusline {
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        hl_group = "lualine_c_normal",
      }
      table.insert(opts.sections.lualine_c or { "filetype" }, {
        symbols.get,
        cond = symbols.has,
      })
      table.insert(opts.sections.lualine_x, Snacks.profiler.status())
    end,
  },
}
