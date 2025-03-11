return
{
  "shellRaining/hlchunk.nvim",
  lazy = true,
  opts = {
    indent = {
      enable = true,
      priority = 10,
      -- style = { "#888888" },
      use_treesitter = false,
      chars = {
        "¦",
        "┆",
        "┊",
      },
      -- ahead_lines = 20,
      delay = 100
    },
    chunk = {
      enable = false,
    },
    blank = {
      enabled = false,
      priority = 5
    },
    line_num = {
      enable = false,
      priority = 4
    }
  },
  keys = {
    {
      mode = "n",
      "<C-i>",
      function()
        if vim.g.hlchunkDisabled then
          vim.cmd("EnableHLIndent")
        else
          vim.cmd("DisableHLIndent")
        end
        vim.g.hlchunkDisabled = not vim.g.hlchunkDisabled
      end,
      desc = "DisableHLIndent",
      noremap = true,
      silent = true,
    },
  },

  config = function(_, opts)
    require("hlchunk").setup(opts)
    vim.g.hlchunkDisabled = true
  end,

}
