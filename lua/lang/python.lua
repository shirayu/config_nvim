if vim.bo.filetype == "python" then
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" and dir ~= "" do
    local venv_bin = dir .. "/.venv/bin"
    if vim.fn.isdirectory(venv_bin) == 1 then
      local path = venv_bin .. ":" .. vim.env.PATH
      vim.env.PATH = path
      break
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
end
