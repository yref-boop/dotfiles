local config = function()
  require('lualine').setup {
    sections = sections,
    options = options
  }
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {"ryanoasis/vim-devicons"},
  lazy = false,
  config = config,
}
