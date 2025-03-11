return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "warmer",
  },
  config = function()
    vim.cmd.colorscheme("onedark")

    vim.api.nvim_set_hl(0,         "SpellBad",   { bg = "#fce3fc", underline = true })
    -- vim.api.nvim_set_hl(0,         "SpellCap",   { bg = "#fce3fc", underline = true })
    -- vim.api.nvim_set_hl(0,         "SpellLocal", { bg = "#fce3fc", underline = true })
    -- vim.api.nvim_set_hl(0,         "SpellRare",  { bg = "#fce3fc", underline = true })
  end
}
