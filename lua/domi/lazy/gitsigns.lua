-- git diff in buffers

return {
    'lewis6991/gitsigns.nvim',
    tag = 'v1.0.2',
    config = function()
        require('gitsigns').setup()
    end,
}
