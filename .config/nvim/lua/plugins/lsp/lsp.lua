local config = function()

  local lsp = require'lspconfig'

  -- language setups
  lsp.lua_ls.setup {}
  lsp.julials.setup {}
  lsp.ocamllsp.setup {}
  lsp.hls.setup {
      root_dir = (require"lspconfig/util").root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml", ".git")
  }
  lsp.clangd.setup {}
  lsp.jedi_language_server.setup {}
  lsp.erlangls.setup {}
  lsp.bashls.setup {}
  lsp.jdtls.setup {
      root_dir = (require"lspconfig/util").root_pattern('build.xml', 'pom.xml', 'settings.gradle', 'settings.gradle.kts', '.git')
  }
  lsp.angularls.setup{}
  lsp.ltex.setup{}


  -- don't show diagnostic messages on a line
  local format = function (diagnostic)
    return string.format ("", diagnostic)
  end

  -- only show prefix '󰑊' next to text
  vim.lsp.handlers ["textDocument/publishDiagnostics"] = vim.lsp.with (
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = {
        spacing = 2,
        prefix = '󰑊',
        format = format
      },
      update_in_insert = false,
      underline = true
    }
  )

  -- show 󰑊 as signcolumn icon
  local signs = {Error = '󰑊', Warn = '󰑊', Hint = '󰑊', Info = '󰑊'}
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  -- hover shows line diagnostics
  vim.o.updatetime = 750
  vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

  -- show info about symbol under cursor
  vim.keymap.set ('n', 'K', vim.lsp.buf.hover, {})

  -- code actions
  vim.keymap.set ({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})


end


return {
  "neovim/nvim-lspconfig",
  event = {
    "BufReadPre", "BufNewFile"
  },
  config = config
}
