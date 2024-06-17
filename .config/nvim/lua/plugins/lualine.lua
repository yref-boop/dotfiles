local theme = function ()
  local colors = {
    darkgray = '#07080d',
    gray     = '#9b9ea4',
    outerbg  = '#100910',
    command  = '#ffe6f6',
    insert   = '#b3f6c0',
    normal   = '#8cf8f7',
    replace  = '#fce094',
    visual   = '#ffcaff',
  }

  return {
    command= {
      a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
      b = { fg = nil, bg = nil },
      c = { fg = nil, bg = nil }
    },
    innactive= {
      a = { fg = colors.darkgray, bg = colors.innactive, gui = "bold" },
      b = { fg = nil, bg = nil },
      c = { fg = nil, bg = nil }
    },
    insert = {
      a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
      b = { fg = nil, bg = nil },
      c = { fg = nil, bg = nil }
    },
    normal = {
      a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
      b = { fg = nil, bg = nil },
      c = { fg = nil, bg = nil }
    },
    replace = {
      a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
      b = { fg = nil, bg = nil },
      c = { fg = nil, bg = nil }
    },
    visual= {
      a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
      b = { fg = nil, bg = nil },
      c = { fg = nil, bg = nil }
    },
  }
end

local config = function()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      globalstatus = false,
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
      theme = theme()
    }
  }
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {"ryanoasis/vim-devicons"},
  lazy = false,
  config = config,
}
