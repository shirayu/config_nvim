local function format_code()
    if vim.bo.filetype == "python" then
        vim.cmd("CocCommand python.sortImports")
    elseif vim.bo.filetype == "markdown" then
        local spath = vim.fn.stdpath("config") .. '/markdownfix.bash'
        ExecForTexts('bash', spath)
        return
    end

    vim.cmd("Format")
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<S-F>", "", { noremap = true, silent = true, callback = format_code })
    end,
})
