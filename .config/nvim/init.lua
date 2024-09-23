require "options"

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy configuration
local options = {
  defaults = { lazy = true },
  install = { colorscheme = { catppuccin }},
  change_detection = { notify = true },
}

-- set <space as leader>
vim.g.mapleader = " "

require("lazy").setup(
  {
    {import = 'plugins'}
  },
  options
  )
