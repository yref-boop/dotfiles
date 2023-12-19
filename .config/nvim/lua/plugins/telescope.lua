local key = vim.keymap

local config = function()
  local telescope = require("telescope")
  local actions   = require("telescope.actions")

  telescope.setup()
  telescope.load_extension("fzf")

  -- keymaps

  local builtin = require('telescope.builtin')

  key.set ('n', '<leader>ff', builtin.find_files,
    {desc = "fuzzy find files"})
  key.set ('n', '<leader>fg', builtin.live_grep,
    {desc = "find string in "})
  key.set ('n', '<leader>fh', builtin.help_tags, {})

  -- lsp keymaps
  key.set ('n', '<leader>fe', builtin.diagnostics,
    { desc = "find errors" })
  key.set ('n', '<leader>fd', builtin.lsp_definitions,
    { desc = "find definition" })
  key.set ('n', '<leader>ft', builtin.lsp_type_definitions,
    { desc = "find type definition" })
  key.set ('n', '<leader>fi', builtin.lsp_implementations,
    { desc = "find implementation" })

  -- git keymaps
  key.set ('n', '<leader>gc', builtin.git_commits,
    { desc = "git commits" })
  key.set ('n', '<leader>gb', builtin.git_branches,
    { desc = "git branches" })


end

return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = config,
}
