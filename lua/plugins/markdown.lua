return {
    "kannokanno/previm",
    ft = {
        "markdown",
    },
    config = function()
        if vim.fn.has("unix") == 1 then
            vim.g.previm_open_cmd = "google-chrome"
        end

        if vim.fn.has("mac") == 1 then
            vim.g.previm_open_cmd = 'open "/Applications/Google Chrome.app"'
        end

        -- if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
        --     -- Add your Windows-specific command here
        -- end

        vim.api.nvim_set_keymap("n", "pv", ":PrevimOpen<CR>", { noremap = true, silent = true })
    end,
}
