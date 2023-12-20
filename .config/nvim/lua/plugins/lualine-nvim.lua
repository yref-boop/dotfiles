local sections = {

  lualine_a = {
    {
      'mode',
      separator = { left = '', right = '' },
    },

    {
      'filetype',
      colored = false,
      icon_only = true,
      color = { fg = '#fde8e7', bg = '#100910'}
    },

    {"filename", color = "StatusLine"},

    {
      function()
        return ''
      end,
      separator = { left = "", right = "" },
    }
  },

  lualine_b = {
    {
      "filesize",
      color = "StatusLine",
      separator = { right = "" },
    }
  },

  lualine_c = {
    {
      "diagnostics",
      sources = { "nvim_lsp" },
      sections = { "error", "warn", "info", "hint" },
      colored = true,
      update_in_insert = true,
      always_visible = false,
      symbols = { error = '', warn = '', info = '', hint = '' }
    }
  },
  lualine_x = {},
  lualine_y = {
    {
      "diff",
      symbols = { added = '', modified = '', removed = '' },
      color = { fg = '#fde8e7', bg = '#100910'}
    }
  },
  lualine_z = {
    {
      "branch",
      icons_enabled = false,
      separator = { left = "", right = "" }
    },
    {
      "location",
      color = "StatusLine"
    },
    {
      function()
        return ''
      end,
      separator = { left = "", right = "" }
    }
  }
}

local config = function()
  require('lualine').setup {
    sections = sections,
    options = {
      icons_enabled = true,
      globalstatus = false,
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
    }
  }
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {"ryanoasis/vim-devicons"},
  lazy = false,
  config = config,
}
