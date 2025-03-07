return {
    "mattn/sonictemplate-vim",
    init = function()
        vim.g.sonictemplate_vim_template_dir = { vim.fn.expand("~/.config/nvim/template") }

        vim.api.nvim_create_autocmd("BufNewFile", {
            pattern = "*.py,*.*sh",
            command = "Template default",
        })
    end,
}
