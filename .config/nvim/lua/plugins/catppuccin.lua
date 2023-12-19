return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      term_colors = true,
      color_overrides = {
        all = { text = "#fde8e7" }
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
      },
    })

    -- setup colorscheme
    vim.cmd('colorscheme catppuccin')

  end
}
