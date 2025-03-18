local function unicode_at_cursor()
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1], pos[2]

  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  if not line or col >= vim.fn.strchars(line) then
    return ""
  end

  local char = vim.fn.strcharpart(line, col, 1)
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
