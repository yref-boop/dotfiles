local config = function ()

  local mason = require ("mason")
  local mason_lsp = require ("mason-lspconfig")

  mason.setup ({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
  })

  -- always after mason setup
  mason_lsp.setup ({
    ensure_installed = {
      "lua_ls",               -- lua
      "julials",              -- julia
      "ocamllsp",             -- ocaml
      "hls",                  -- haskell
      "clangd",               -- c
      "bashls",               -- bash
      "jedi_language_server", -- python
      "erlangls",             -- erlang
      "jdtls",                -- java
      "ltex",                 -- latex
    },

    -- install lsp-configured langs
    automatic_installation = true
  })

end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  lazy = false,
  config = config
}
