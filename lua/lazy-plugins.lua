-- [[ Configure and install plugins ]]
require("lazy").setup({
  { import = "plugins" },
}, {
  checker = { enabled = true },
  install = {
    colorscheme = { "catppuccin", "default" },
  },
  rocks = {
    server = "https://lux.lumen-labs.org/rocks-binaries/",
  },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
    border = "rounded",
  },
})

-- vim: ts=2 sts=2 sw=2 et
