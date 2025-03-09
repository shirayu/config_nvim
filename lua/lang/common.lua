local function format_code()
    if vim.bo.filetype == "python" then
        vim.cmd("CocCommand python.sortImports")
    end
    vim.cmd("Format")
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<S-F>", "", { noremap = true, silent = true, callback = format_code })
    end,
})
