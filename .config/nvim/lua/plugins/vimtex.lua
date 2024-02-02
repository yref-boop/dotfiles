local config = function ()
  vim.cmd("let g:vimtex_view_method = 'zathura'")
  vim.cmd("let g:tex_flavor='lualatex'")
end

return {
  'lervag/vimtex',
  lazy = false,
  config = config
}
