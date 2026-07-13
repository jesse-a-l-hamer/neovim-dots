---@class CompletionSourceInfo
---
---@field doc_hover_opts? DocHoverOpts

--- sources which are used under general circumstances
---@type table<string, CompletionSourceInfo>
local base_sources = {
  lazydev = { doc_hover_opts = { footer_text = " lazydev" } },
  lsp = { doc_hover_opts = { footer_text = " lsp" } },
  path = { doc_hover_opts = { footer_text = " path" } },
  snippets = { doc_hover_opts = { footer_text = " snippets" } },
  git = { doc_hover_opts = { footer_text = " git" } },
  buffer = { doc_hover_opts = { footer_text = " buffer" } },
  emoji = { doc_hover_opts = { footer_text = " emoji" } },
  cmdline = { doc_hover_opts = { footer_text = " cmdline" } },
  omni = { doc_hover_opts = { footer_text = " omni" } },
  references = { doc_hover_opts = { footer_text = " references" } },
  ecolog = { doc_hover_opts = { footer_text = " ecolog" } },
  sshconfig = { doc_hover_opts = { footer_text = "󰣀 sshconfig" } },
  fonts = { doc_hover_opts = { footer_text = "󰀬 fonts" } },
  dap = { doc_hover_opts = { footer_text = " dap" } },
  css_vars = { doc_hover_opts = { footer_text = " css-vars" } },
}

--- sources which are only used under specific circumstances
---@type table<string, CompletionSourceInfo>
local optional_sources = {
  dictionary = { doc_hover_opts = { footer_text = "󱓳 dictionary" } },
  thesaurus = { doc_hover_opts = { footer_text = "󰗛 thesaurus" } },
}

local default_sources = function(ctx)
  local success, node = pcall(vim.treesitter.get_node)
  -- check if we're in a special node and can return a subset of providers...
  if
    success
    and node
    and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
  then
    return { "buffer", "dictionary", "thesaurus", "emoji" }
  end
  -- ...otherwise just return the base providers
  return vim.tbl_keys(base_sources)
end

---@param opts blink.cmp.CompletionDocumentationDrawOpts
local update_doc_win_config = function(opts)
  local win_config = {}
  local buf = opts.window:get_buf()

  ---@type { default: DocHoverOpts, [string]: DocHoverOpts }
  local source_doc_hover_opts = {
    default = {
      border_hl = "FloatBorder",
      footer_text = "",
      footer_text_hl = "FloatBorder",
    },
  }
  for source_id, source_info in
    pairs(vim.tbl_extend("error", base_sources, optional_sources))
  do
    source_doc_hover_opts[source_id] = source_info.doc_hover_opts
  end
  local source_ids = vim.tbl_keys(source_doc_hover_opts)
  table.sort(source_ids)

  ---@type table<string,DocHoverOpts>
  local lsp_doc_hover_opts = {}
  for client_name, client_info in pairs(vim.g.lsp_client_info) do
    lsp_doc_hover_opts[client_name] = client_info.doc_hover_opts
  end
  local lsp_client_names = vim.tbl_keys(lsp_doc_hover_opts)
  table.sort(lsp_client_names)

  local source_id = opts.item.source_id
  local client_name = opts.item.client_name
  local ignore = { "default" }

  ---@type DocHoverOpts
  local doc_hover_opts = source_doc_hover_opts.default

  if source_id == "lsp" and client_name then
    doc_hover_opts = vim.tbl_extend("force", doc_hover_opts, lsp_doc_hover_opts.default)
    for _, k in ipairs(lsp_client_names) do
      if vim.list_contains(ignore, k) == false and string.match(client_name, k) then
        doc_hover_opts = vim.tbl_extend("force", doc_hover_opts, lsp_doc_hover_opts[k])
        break
      end
    end
  else
    for _, k in ipairs(source_ids) do
      if vim.list_contains(ignore, k) == false and string.match(source_id, k) then
        doc_hover_opts =
          vim.tbl_extend("force", doc_hover_opts, source_doc_hover_opts[k])
        break
      end
    end
  end

  if doc_hover_opts.footer_text then
    win_config.footer = {
      { "╼ ", doc_hover_opts.border_hl or "FloatBorder" },
      {
        doc_hover_opts.footer_text,
        doc_hover_opts.footer_text_hl or doc_hover_opts.border_hl or "FloatBorder",
      },
      { " ╾", doc_hover_opts.border_hl or "FloatBorder" },
    }
    win_config.footer_pos = "right"
  end

  if vim.g.__reg_doc ~= true then
    vim.treesitter.language.register("markdown", "blink-cmp-documentation")
    vim.g.__reg_doc = true
  end

  if package.loaded["render-markdown"] then
    local win = opts.window:get_win()

    if win then
      vim.wo[win].conceallevel = 3
      if win_config then
        vim.api.nvim_win_set_config(
          win,
          vim.tbl_deep_extend("force", vim.api.nvim_win_get_config(win), win_config)
        )
      end
      vim.bo[buf].ft = "markdown"
      require("render-markdown.core.ui").update(buf, win, "BlinkDraw", true)
      vim.bo[buf].ft = "blink-cmp-documentation"
    end

    vim.defer_fn(function()
      win = opts.window:get_win()

      if win then
        vim.wo[win].signcolumn = "no"
        vim.wo[win].conceallevel = 3
        if win_config then
          vim.api.nvim_win_set_config(
            win,
            vim.tbl_deep_extend("force", vim.api.nvim_win_get_config(win), win_config)
          )
        end
        vim.bo[buf].ft = "markdown"
        require("render-markdown.core.ui").update(buf, win, "BlinkDraw", true)
        vim.bo[buf].ft = "blink-cmp-documentation"
      end
    end, 25)
  end
end

---@module 'lazy'

---@type LazyPluginSpec[]
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "MeanderingProgrammer/render-markdown.nvim",
      "xzbdmw/colorful-menu.nvim",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",

      -- provider dependencies:

      "moyiz/blink-emoji.nvim",
      "archie-judd/blink-cmp-words",
      {
        "Kaiser-Yang/blink-cmp-git",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      "jmbuhr/cmp-pandoc-references",
      {
        "bydlw98/blink-cmp-sshconfig",
        build = "make",
      },
      "amarakon/nvim-cmp-fonts",
      "rcarriga/cmp-dap",
      "jdrupal-dev/css-vars.nvim",
    },
    version = "*",
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<C-u>"] = { "scroll_signature_up", "fallback" },
        ["<C-d>"] = { "scroll_signature_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          draw = {
            padding = { 0, 1 }, -- padding only on right side
            columns = {
              { "kind_icon" },
              { "label", gap = 1 },
              { "source_name" },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbol_map[ctx.kind] or ""
                  end
                  return " " .. icon .. ctx.icon_gap .. " "
                end,
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl =
                      require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(
                      highlights,
                      { idx, idx + 1, group = "BlinkCmpLabelMatch" }
                    )
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
            treesitter = { "lsp", "dap" },
          },
        },
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            min_width = 20,
            max_width = math.floor(vim.o.columns * 0.75),
            max_height = math.floor(vim.o.lines * 0.5),
          },
          draw = function(opts)
            opts.default_implementation()
            update_doc_win_config(opts)
          end,
        },
        ghost_text = { enabled = true, show_with_selection = true },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      -- NOTE: custom docs drawing for signature help not yet supported (2025-07-23)
      signature = {
        enabled = true,
        trigger = { enabled = false },
        window = {
          winblend = 10,
          scrollbar = true,
        },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
      },
      sources = {
        default = default_sources,
        per_filetype = {
          markdown = {
            inherit_defaults = true,
            "dictionary",
            "thesaurus",
          },
          typst = {
            inherit_defaults = true,
            "dictionary",
            "thesaurus",
          },
          latex = {
            inherit_defaults = true,
            "dictionary",
            "thesaurus",
          },
          text = {
            inherit_defaults = true,
            "dictionary",
            "thesaurus",
          },
          sql = {
            "snippets", "dadbod", "buffer",
          }
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          emoji = {
            name = "Emoji",
            module = "blink-emoji",
            score_offset = 15,
            opts = {
              insert = true, -- Insert emoji (default) or complete its name
              ---@type string|table|fun():table
              trigger = function()
                return { ":" }
              end,
            },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
            end,
          },
          dictionary = {
            module = "blink-cmp-words.dictionary",
            name = "Dictionary",
            max_items = 10,
            opts = {
              score_offset = 0,
            },
          },
          thesaurus = {
            module = "blink-cmp-words.thesaurus",
            name = "Thesaurus",
            max_items = 5,
            opts = {
              score_offset = 0,
            },
          },
          git = {
            score_offset = 100,
            module = "blink-cmp-git",
            name = "Git",
            enabled = true,
            should_show_items = function()
              return vim.o.filetype == "gitcommit" or vim.o.filetype == "markdown"
            end,
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            opts = {},
          },
          references = {
            name = "References",
            module = "cmp-pandoc-references.blink",
          },
          ecolog = {
            name = "ecolog",
            module = "ecolog.integrations.cmp.blink_cmp",
          },
          sshconfig = {
            name = "SshConfig",
            module = "blink-cmp-sshconfig",
          },
          fonts = {
            name = "fonts",
            module = "blink.compat.source",
            score_offset = -3,
            enabled = function()
              return vim.o.filetype == "conf" or vim.o.filetype == "config"
            end,
            opts = {
              cmp_name = "Fonts",
            },
          },
          dap = {
            name = "dap",
            module = "blink.compat.source",
            enabled = function()
              return (vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer())
                and (
                  vim.tbl_contains(
                    { "dap-repl", "dapui_watches", "dapui_hover" },
                    vim.o.filetype
                  )
                )
            end,
            opts = {
              cmp_name = "DAP",
            },
          },
          css_vars = {
            name = "css-vars",
            module = "css-vars.blink",
            opts = {
              search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
            },
          },
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
          }
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
