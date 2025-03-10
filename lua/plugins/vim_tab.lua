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

        for _, key in ipairs({ "<leader>bn", "<C-n>" }) do
            vim.keymap.set("n", key, ":bn<CR>", { desc = "Next buffer", noremap = true, silent = true })
        end

        for _, key in ipairs({ "<leader>bp", "<C-p>" }) do
            vim.keymap.set("n", key, ":bp<CR>", { desc = "Prevout buffer", noremap = true, silent = true })
        end
    end,
    opts = {
    },
}
