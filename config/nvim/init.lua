# Requires paq to be installed: https://github.com/savq/paq-nvim
require "paq" {
    "savq/paq-nvim",
    "neovim/nvim-lspconfig",
}

local nvim_lsp = require('lspconfig')
vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }),
  callback = function()
    vim.lsp.start {
      name = "standard",
      cmd = { "standardrb", "--lsp" },
    }
  end,
})

require'lspconfig'.eslint.setup{}

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])
