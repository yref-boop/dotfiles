local config = function ()
  require'nvim-treesitter'.setup{
    ensure_installed = {
      "c",
      "lua",
      "python",
      "matlab",
      "latex",
    },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = config
}
