local config = function ()
  require'lspconfig'.pyright.setup{}
  require'lspconfig'.clangd.setup{}
  require'lspconfig'.matlab_ls.setup{}
  require'lspconfig'.lua_ls.setup{}
  require'lspconfig'.asm_lsp.setup{}
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = config
}
