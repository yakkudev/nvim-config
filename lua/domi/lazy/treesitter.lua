-- treesitter (everybody knows what treesitter is)
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { "c3" },
            callback = function() vim.treesitter.start() end,
            once = true,
        })
        require("nvim-treesitter").setup({
            ensure_installed = {
                "gitignore", "gitattributes",
                "lua", "vim", "vimdoc",
                "c", "cpp", "rust", "c3",
                "javascript", "html", "css", "json", "json5",
                "python",
            },
        })
    end
}
