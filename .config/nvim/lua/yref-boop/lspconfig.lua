local lsp_installer = require("nvim-lsp-installer")
local util = require("lspconfig/util")
local configs = require "lspconfig/configs"

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).


lsp_installer.on_server_ready(function(server)
    local opts = {}
    root_dir = util.root_pattern('*.sln', '*.fsproj', '.git')
    
    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end
    if server.name == "hls" then
        opts.root_dir = util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml", ".git")
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    server:setup(opts)


end)
