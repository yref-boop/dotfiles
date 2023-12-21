local config = function()

  require 'nvim-treesitter.configs'.setup({

    -- languages
    ensure_installed = {'lua','julia','ocaml','haskell','c','java','erlang','bash'},
    auto_install = true,

    -- syntax highlight
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },

    -- indent (testing)
    indent = {enable = true},

    -- based on the named nodes
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm"
      }
    }

    -- TODO: textobjects (& keymaps)
  })

end

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = config,
  event = {'BufReadPre', 'BufNewFile'}
}
