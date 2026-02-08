local M = {}
local lspconfig = require("lspconfig")

local util = require('lspconfig/util')
local configs = require('lspconfig.configs')
if not configs.c3_lsp then
    configs.c3_lsp = {
        default_config = {
            cmd = { "/usr/bin/c3lsp" },
            filetypes = { "c3", "c3i" },
            root_dir = function(fname)
                return util.find_git_ancestor(fname)
            end,
            settings = {},
            name = "c3_lsp"
        }
    }
end
lspconfig.c3_lsp.setup{}

M.ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "c3-lsp", "ols" };

M.get_handlers = function(capabilities)
    return {
        function(server_name) -- default handler
            lspconfig[server_name].setup {
                capabilities = capabilities
            }
        end,

        clangd = function()
            lspconfig.clangd.setup({capabilities = capabilities, })
        end,

        c3_lsp = function()
            lspconfig.clangd.setup({capabilities = capabilities, })
        end,

    }
end

return M
