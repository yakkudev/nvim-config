local M = {}
local lspconfig = vim.lsp.config

M.ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "c3-lsp" };

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
    }
end

return M
