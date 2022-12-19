require "yref-boop.options"
require "yref-boop.plugins"
require "yref-boop.gitsigns"
require "yref-boop.lualine"
require "yref-boop.lspconfig"
require "yref-boop.colors"
require "yref-boop.code_runner"

-- limit severity of lsp messages
vim.diagnostic.config({
    virtual_text = {severity = {min = vim.diagnostic.severity.WARN}},
    signs = {severity = {min = vim.diagnostic.severity.WARN}},
    underline = {severity = {min = vim.diagnostic.severity.WARN}},
})

