local fn = vim.fn

-- install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- packer popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=none guifg=#9da5b3")



-- plugins
return packer.startup(function(use)
    use "wbthomason/packer.nvim"                -- packer manage
    use "nvim-lua/popup.nvim"                   -- popup API from vim in Neovim
    
    use "nvim-lua/plenary.nvim"                 -- auxiliary plugin
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use "norcalli/nvim-colorizer.lua"           -- shows hex color values

    use { "kyazdani42/nvim-tree.lua"}           -- file system

    use { "catppuccin/nvim",                    -- catppuccin
        as = "catppuccin" }

    use {'nvim-treesitter/nvim-treesitter',     -- treesitter
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use "L3MON4D3/LuaSnip"                      -- snippet engine

    use "godlygeek/tabular"                     -- beautify code
    use "lukas-reineke/indent-blankline.nvim"   -- blank characters
    use "xiyaowong/virt-column.nvim"            -- add indicator on line 80

    use {'CRAG666/code_runner.nvim',            -- execute code from nvim
            requires = 'nvim-lua/plenary.nvim'
    }

    use {                                       -- language server protocol
        "williamboman/mason.nvim",              -- lsp package manager
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use 'lervag/vimtex'                         -- latex

    use "TimUntersberger/neogit"                -- git support for nvim
    use "lewis6991/gitsigns.nvim"               -- git integration

    use "ryanoasis/vim-devicons"                -- language icons
    use "gelguy/wilder.nvim"                    -- better suggestions 
    
    use "mfussenegger/nvim-dap"                 -- debug

    use "beauwilliams/focus.nvim"               -- split windows
 

    -- telescope searcher

    use "benfowler/telescope-luasnip.nvim"
    use 'nvim-telescope/telescope-media-files.nvim'
    use "nvim-telescope/telescope-ui-select.nvim"

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end

end)
