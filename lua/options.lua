-- [[ Configure global options (i.e., vim.o.<...>) ]]
vim.o.number = true
vim.o.relativenumber = true

-- mouse settings
vim.o.mouse = "a"
vim.o.mousescroll = "ver:1,hor:1"

vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.wrap = true

vim.o.breakindent = true
vim.o.showbreak = ""

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"
vim.o.colorcolumn = "88"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"

vim.o.inccommand = "split"

vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.scrolloff = 10

vim.o.winborder = "rounded"
vim.o.pumblend = 10 -- popup menu
vim.o.winblend = 10 -- floating windows

vim.o.dictionary = "/usr/share/dict/words"
-- vim: ts=2 sts=2 sw=2 et
