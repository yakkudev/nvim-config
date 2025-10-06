-- the goddamn lsp config
-- todo: make another file where all servers are neatly together without all the other bs
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip", -- snippets
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "j-hui/fidget.nvim", -- notifs
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                clangd = function()
                    require("lspconfig").clangd.setup({capabilities = capabilities, })
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- load snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        local lspkind = require("lspkind")

        -- setup completions
        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol",
                    maxwidth = {
                        menu = 30,
                        abbr = 50,
                    },
                    ellipsis_char = "...",
                    show_labelDetails = true,

                    before = function (entry, vim_item)
                        return vim_item
                    end
                })
            },

            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            -- completion bindings
            mapping = cmp.mapping.preset.insert({
                ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select), -- next
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select), -- previous
                ['<C-Enter>'] = cmp.mapping.confirm({ select = true }), -- select and confirm
                ['<Enter>'] = cmp.mapping.confirm(), -- confirm only if has a completion selected
                ['<C-Space>'] = cmp.mapping.complete(), -- open completion menu
            }),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer', keyword_length = 2 },
            })
        })

        -- warn/error messages
        vim.diagnostic.config({
            update_in_insert = false,
            underline = true,
            signs = true,
            virtual_lines = { current_line = true },

            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
