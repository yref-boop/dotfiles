require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true,
    term_colors = true,
    dim_inactive = {
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {
        all = {

            text =      "#fde8e7",

            blue =      "#f783eb", -- constructor
            yellow =    "#b987ff", -- types & warnings
            mauve =     "#f5be8a", -- tag
            sky =       "#a3c9d5", -- operators

            rosewater = "#f5e0dc", -- winbar
            flamingo =  "#f2cdcd", --target word
            pink =      "#f5c2e7", --just pink

            red =       "#f38bb8", --error
            maroon =    "#eba0ac", --lighter red
            peach =     "#fab387", --number
            green =     "#a6e3a1", -- diff add
            teal =      "#94e2d5", -- hint
            sapphire =  "#74c7ec", --constructor func definition
            lavender =  "#b4befe",

        },
    },
      highlight_overrides = {
                all = function(colors)
            return {
                    NvimTreeNormal = { fg = colors.none },
                    CmpBorder = { fg = "#3e4145" },
                    ColorColumn = { ctermbg = "#111011"}
                }
        end,
                latte = function(latte)
            return {
                    Normal = { fg = latte.base },
                }
        end,
                frappe = function(frappe)
            return {
                    ["@comment"] = { fg = frappe.surface2, style = { "italic" } },
                }
        end,
                macchiato = function(macchiato)
            return {
                    LineNr = { fg = macchiato.overlay1 },
                }
        end,
                mocha = function(mocha)
            return {
                }
        end,
            },
    custom_highlights = {
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
