local function format_code()
  if vim.bo.filetype == "python" then
    vim.cmd("CocCommand python.sortImports")
  elseif vim.bo.filetype == "markdown" then
    local spath = vim.fn.stdpath("config") .. "/markdownfix.sh"
    ExecForTexts("bash", spath)
    return
  elseif vim.bo.filetype == "sh" or vim.bo.filetype == "zsh" then
    ExecForTexts("shfmt", "-i 4 -ci -bn -s")
    return
  end

  vim.cmd("Format")
end

local function format_code_json_sorted()
  ExecForTexts("python3",
    '-c "import sys,json;print(json.dumps(json.loads(sys.stdin.read()),indent=2,ensure_ascii=False,sort_keys=True))"')
  vim.cmd("Format")
end

-- Shift + F
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<S-F>", "", { noremap = true, silent = true, callback = format_code })
  end,
})

-- Shift + O
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<S-O>", "",
      { noremap = true, silent = true, callback = format_code_json_sorted })
  end,
})
