aux_theme = function()
    local colors = {
            darkgray = "#16161d",
            gray = "#727169",
            outerbg = "#16161D",
            normal = "#7e9cd8",
            insert = "#98bb6c",
            visual = "#ffa066",
            replace = "#e46876",
            command = "#e6c384",
    }
    return {
            inactive = {
                a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = nil },
            },
            visual = {
                a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = nil },
            },
            replace = {
                a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = nil },
            },
            normal = {
                a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = nil },
            },
            insert = {
                a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = nil },
            },
            command = {
                a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
                b = { fg = colors.gray, bg = colors.outerbg },
                c = { fg = colors.gray, bg = nil },
            },
        }
end


local present, lualine = pcall(require, "lualine")
if not present then
    return
end

local layout = {
    lualine_a = {
        {
            "mode",
			separator = { left = "", right = "" },
        },
        {"filetype", color = "StatusLine"},
        {"filename", color = "StatusLine"},
        {
			function()
				return ""
			end,
			separator = { left = "", right = "" },
		},
    },
    lualine_b = {
        {
            "filesize", 
            color = "StatusLine",
            separator = { right = "" },
        },
    },

    lualine_c = {
        {
			"diagnostics",
			sources = { "nvim_lsp" },
			sections = {
				"error",
				"warn",
			},
			diagnostic_color = {
				error = { fg = '#820e2d', bg = '#0f111a' },
				warn = { fg = 'DiagnosticWarn', bg = '#0f111a' },
				info = { fg = 'DiaganosticInfo', bg = '#0f111a' },
				hint = { fg = '#92CDE7', bg = '#0f111a' },
			},
			colored = true,
			update_in_insert = true,
			always_visible = false,
			symbols = {
				error = "",
				warn = "",
			},
        },

    },
    lualine_x = {
    },
    lualine_y = {
    },
    lualine_z = {
        {
            "diff",
			symbols = {
				added = "",
				modified = "~",
				removed = "-",
            },
            color = "StatusLine",
            --separator = { left = ""},
        },
        {
            --function()
            --    return " "
            --end,
            "branch",
            separator = { left = "", right = "" }
        },
        {
			"location",
            color = "StatusLine",
		},
		{
			function()
				return ""
			end,
			separator = { left = "", right = "" },
		},

    },

}

local no_layout = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = {},
}

lualine.setup({
	sections = layout,
	inactive_sections = no_layout,
	options = {
		icons_enabled = true,
		globalstatus = false,
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
        theme = aux_theme()
	},
})
