return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false

        -- buffer
        vim.keymap.set("n", "<leader>bc", ":BufferClose<CR>",
            { desc = "Close buffer", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Prevout buffer", noremap = true, silent = true })
    end,
    opts = {
    },
}
