local which_key = require("which-key")

-- save file with ctrl+s
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<cmd>w<cr>", { desc = "Save file", silent = true })

-- toggle comments
vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment" })
vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" })

-- :qq to save everything and quit gracefully, :QQ to ragequit
vim.api.nvim_create_user_command("Qq", "wqa", {})
vim.cmd([[cnoreabbrev <expr> qq  (getcmdtype() == ':' ? 'Qq' : 'qq')]]) -- set qq to alias Qq (user cmds must start with capital letter)
vim.api.nvim_create_user_command("QQ", "qa!", {})

-- lsp goto
vim.keymap.set("n", "<C-g>", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

-- semicolon insert at end of line :)
vim.keymap.set("n", ";", function()
    local line = vim.api.nvim_get_current_line()
    if not line:match(";%s*$") then
        vim.api.nvim_set_current_line(line .. ";")
    end
    vim.cmd("normal! $") -- move cursor to end of line
end, { desc = "Smart semicolon at end of line" })

-- tree focus
local tree = require("nvim-tree.api").tree;
vim.keymap.set("n", "<leader>e", tree.focus, { desc = "Open file explorer" })

-- telescope bindings
local builtin = require('telescope.builtin')
local telescope_mappings = {
    f = {
        name = "Find",
        f = { builtin.find_files, "Find files" },
        g = { builtin.git_files, "Find git files" },
        l = { builtin.live_grep, "Live grep" },
    },
}

which_key.register(telescope_mappings, { prefix = "<leader>" })

-- move selection up/down
local move_mappings  = {
    J = { ":m '>+1<CR>gv=gv", "Move selection down" },
    K = { ":m '<-2<CR>gv=gv", "Move selection up" },
}

which_key.register(move_mappings, { mode = "v" })


