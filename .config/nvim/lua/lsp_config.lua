require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",          -- lua
        "julials",              -- julia
        "ocamllsp",             -- ocaml
        "hls",                  -- haskell
        "clangd",               -- c
        "bashls",               -- bash
        "jedi_language_server", -- python
        "erlangls",             -- erlang
        "jdtls",                -- java
        "ltex",                 -- latex
    }
})

require("lspconfig").lua_ls.setup {}
require("lspconfig").julials.setup {}
require("lspconfig").ocamllsp.setup {}
require("lspconfig").hls.setup {
    root_dir = (require"lspconfig/util").root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml", ".git")
}
require("lspconfig").clangd.setup {}
require("lspconfig").jedi_language_server.setup {}
require("lspconfig").erlangls.setup {}
require("lspconfig").bashls.setup {}
require("lspconfig").jdtls.setup{
    root_dir = (require"lspconfig/util").root_pattern('build.xml', 'pom.xml', 'settings.gradle', 'settings.gradle.kts', '.git')
}
require("lspconfig").ltex.setup{}
