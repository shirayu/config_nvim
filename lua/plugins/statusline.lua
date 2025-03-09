return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = { theme = "ayu_dark" },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 0,
                    },
                    "@",
                    {
                        "filename",
                        file_status = false, -- displays file status (readonly status, modified status)
                        path = 2,            -- 0 = just filename, 1 = relative path, 2 = absolute path
                    },
                },
            },
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
