-- treesitter (everybody knows what treesitter is)
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
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
