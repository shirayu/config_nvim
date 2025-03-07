return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = { theme = "ayu_dark" },
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
