-- treesitter (everybody knows what treesitter is)
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c", "rust", "lua", "vim", "vimdoc", "javascript", "html", "python"
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
