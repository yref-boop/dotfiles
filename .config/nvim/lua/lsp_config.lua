require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",          -- lua
        "julials",              -- julia
        "ocamllsp",             -- ocaml
        "hls",                  -- haskell
        "clangd",               -- c
        "bashls",               -- bash
        "jedi_language_server", -- python
        "erlangls",             -- erlang
        "jdtls",                -- java
    }
})



require("lspconfig").sumneko_lua.setup {}
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
