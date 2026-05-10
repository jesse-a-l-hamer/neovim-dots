---@brief
---
--- https://github.com/polarmutex/beancount-language-server#installation
---
--- See https://github.com/polarmutex/beancount-language-server#configuration for configuration options

---@type vim.lsp.Config
return {
  cmd = { "beancount-language-server", "--stdio" },
  filetypes = { "beancount" },
  root_markers = { "main.bean", ".git" },
  init_options = {
    journal_file = "main.bean",
    diagnostic_flags = { "!" },
  },
  settings = {
    beancount = {
      formatting = {
        currency_column = 86,
        num_width = 10,
        account_amount_spacing = 2,
        number_currency_spacing = 1,
        prefix_width = 72
      }
    }
  }
}
