require "yref-boop.options"
require "yref-boop.plugins"
require "yref-boop.gitsigns"
require "yref-boop.lualine"
require "yref-boop.lspconfig"
require "yref-boop.colors"
require "yref-boop.telescope"
require "yref-boop.treesitter"
require "yref-boop.nvim-tree"

-- limit severity of lsp messages
vim.diagnostic.config({
    virtual_text = {severity = {min = vim.diagnostic.severity.WARN}},
    signs = {severity = {min = vim.diagnostic.severity.WARN}},
    underline = {severity = {min = vim.diagnostic.severity.WARN}},
})

-- blocks & spaces indicator
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}

-- vertical column
vim.g.virtcolumn_char = '▕' -- char to display the line
vim.g.virtcolumn_priority = 10 -- priority of extmark
vim.cmd("set colorcolumn=70")
vim.cmd("hi Normal guibg = #171617")
