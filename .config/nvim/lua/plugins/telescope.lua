local key = vim.keymap

local config = function()

  -- safe imports
  local telescope_setup, telescope = pcall(require, 'telescope')
  if not telescope_setup
    then return
  end

  local actions_setup, actions   = pcall(require, 'telescope.actions')
  if not actions_setup
    then return
  end

  -- custom mappings
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<T-k>"] = actions.move_selection_previous,
          ["<T-j>"] = actions.move_selection_next,
          ["<T-q>"] = actions.send_selected_to_qflist + actions.open_qflist
        }
      }
    }
  })

  -- more efficient search
  telescope.load_extension("fzf")


  local builtin = require ('telescope.builtin')

  -- telescope keymaps
  key.set ('n', '<leader>ff', builtin.find_files, {})
  key.set ('n', '<leader>fg', builtin.live_grep, {})
  key.set ('n', '<leader>fh', builtin.help_tags, {})

  -- lsp keymaps
  key.set ('n', '<leader>fe', builtin.diagnostics, {})
  key.set ('n', '<leader>fd', builtin.lsp_definitions, {})
  key.set ('n', '<leader>ft', builtin.lsp_type_definitions, {})
  key.set ('n', '<leader>fi', builtin.lsp_implementations, {})

  -- git keymaps
  key.set ('n', '<leader>gc', builtin.git_commits, {})
  key.set ('n', '<leader>gb', builtin.git_branches, {})


end

return {
  {
    -- telescope
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = config,
  },
  {
    -- telescope-ui
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = false,
    config = function ()
      require("telescope").setup ({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            },
            codeactions = false,
          }
        }
      })
      require('telescope').load_extension('ui-select')
    end
  }
}
