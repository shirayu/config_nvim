local function unicode_at_cursor()
  local line = vim.fn.getline(".")
  local pos = vim.fn.getcursorcharpos(".")[3] - 1
  -- return string.format("[??][%s]", pos)
  local char = vim.fn.strcharpart(line, pos, 1)
  if char == "" then
    return ""
  end
  return string.format("[%s][U+%04X]", char, vim.fn.char2nr(char))
end

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = { theme = "onedark" },
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
        lualine_z = {
          { "location" }, { unicode_at_cursor },
        },
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
