local words = function ()
  local count = vim.fn.wordcount()
  if count['visual_words'] then
    return count['visual_words']
  else
    return count['words']
  end
end

local bongo_cat = function ()

  local left_bong = '΃'
  local right_bong = '΀'
  local left_up = '΁'
  local right_up = '΂'
  local bongo = left_up .. right_up

  local press = function (bongo)
    if (bongo:sub(0,0) == left_up) then
      return left_bong .. right_up
    else
      return left_up .. right_bong
    end
  end

  local move = vim.api.nvim_create_autocmd({'TextChanged'}, {
    callback = function()
    end
  })

  if move % 2 == 0 then
    bongo = press (bongo)
  end

  return bongo

end


local theme = function ()
  local colors = {
    darkgray = '#100910',
    gray     = '#727169',
    outerbg  = '#100910',
    command  = '#ffe6f6',
    insert   = '#cba6f7',
    normal   = '#f8b4ef',
    replace  = '#f2cdcd',
    visual   = '#b4befe',
  }

  return {
    command = { a = { fg = colors.darkgray, bg = colors.command, gui = "bold" } },
    inactive = { a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" } },
    insert = { a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" } },
    normal = {
      a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
      b = { fg = colors.gray, bg = colors.outerbg },
    },
    replace = { a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" } },
    visual = { a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" } },
  }
end

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
  lualine_x = {
    function ()
      return ' '
    end
  },
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
      color = 'StatusLine',
      separator = { left = "", right = "" }
    },
    {
      "location",
      color = 'StatusLine'
    },
    {
      words,
      separator = { left = "", right = "" }},
    {
      bongo_cat,
      color = { bg = '#100910', fg = '#fde8e7'}
    },
    {
      function ()
        return ' '
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
