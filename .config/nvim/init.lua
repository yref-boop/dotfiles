require "yref-boop.options"
require "yref-boop.plugins"
require "yref-boop.gitsigns"
require "yref-boop.lualine"
require "yref-boop.lspconfig"
require "yref-boop.colors"
require "yref-boop.telescope"
require "yref-boop.treesitter"
require "yref-boop.nvim-tree"

--require "yref-boop.coderunner"

-- limit severity of lsp messages
vim.diagnostic.config({
    virtual_text = {severity = {min = vim.diagnostic.severity.WARN}},
    signs = {severity = {min = vim.diagnostic.severity.WARN}},
    underline = {severity = {min = vim.diagnostic.severity.WARN}},
})

vim.cmd("hi Normal guibg = #171617")
