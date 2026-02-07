-- [[ Set global variables (i.e., vim.g.<...>) ]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

---@class DocHoverOpts
---
---@field border_hl? string
---@field footer_text? string
---@field footer_text_hl? string
---@field min_width? integer
---@field max_width? integer
---@field min_height? integer
---@field max_height? integer

---@class LspClientInfo
---
---@field doc_hover_opts? DocHoverOpts

---@type { default: LspClientInfo, [string]: LspClientInfo }
vim.g.lsp_client_info = {
  default = {
    doc_hover_opts = {
      border_hl = "FloatBorder",
      footer_text = "  LSP",
      footer_text_hl = "FloatBorder",

      min_width = 20,
      max_width = math.floor(vim.o.columns * 0.75),

      min_height = 1,
      max_height = math.floor(vim.o.lines * 0.5),
    },
  },
  ["^bashls"] = { doc_hover_opts = { footer_text = "󱆃 BashLS" } },
  ["^beancount-language-server"] = {
    doc_hover_opts = { footer_text = "  beancount-language-server" },
  },
  ["^hyprls"] = { doc_hover_opts = { footer_text = " hyprls" } },
  ["^lua_ls"] = { doc_hover_opts = { footer_text = "  LuaLS" } },
  ["^marksman"] = { doc_hover_opts = { footer_text = "  Marksman" } },
  ["^mutt_ls"] = { doc_hover_opts = { footer_text = "󰺻  mutt-language-server" } },
  ["^ruff"] = { doc_hover_opts = { footer_text = "  Ruff" } },
  ["^systemd_ls"] = {
    doc_hover_opts = { footer_text = "  systemd-language-server" },
  },
  ["^taplo"] = { doc_hover_opts = { footer_text = "  Taplo" } },
  ["^texlab"] = { doc_hover_opts = { footer_text = "  Lab" } },
  ["^tinymist"] = { doc_hover_opts = { footer_text = " Tinymist" } },
  ["^ty"] = { doc_hover_opts = { footer_text = "  ty" } },
  ["^yamlls"] = { doc_hover_opts = { footer_text = " YamlLS" } },
}
