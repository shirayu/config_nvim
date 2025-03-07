return {
    "nvim-tree/nvim-tree.lua",
    opts = {
        view = {
            side = "right",
        },
    },
    keys = {
        {
            mode = "n",
            "<C-f>",
            "<cmd>NvimTreeToggle<CR>",
            desc = "Toggle NvimTree",
            noremap = true,
            silent = true,
        },
    },
}
