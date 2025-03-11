return {
  "vim-scripts/yanktmp.vim",
  config = function()
    local yanktmp_file = "/tmp/." .. vim.env.USER .. ".vimyanktmp"

    if vim.fn.filereadable(yanktmp_file) == 0 then
      vim.fn.writefile({}, yanktmp_file)
      if vim.fn.has("unix") == 1 then
        vim.fn.system("chmod 600 " .. yanktmp_file)
      end
    end

    -- normalモード(n)
    vim.keymap.set("n", "sy", ":call YanktmpYank()<CR>",    { noremap = true, silent = true })
    -- visualモード(x)
    vim.keymap.set("x", "sy", ":call YanktmpYank()<CR>",    { noremap = true, silent = true })

    vim.keymap.set("n", "sp", ":call YanktmpPaste_p()<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "sP", ":call YanktmpPaste_P()<CR>", { noremap = true, silent = true })
  end,
}
