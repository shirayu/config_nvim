return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      options = {
        parsers = {
          names = { enable = false },
        },
        display = {
          mode = "background",
        },
      },
    },
  },
  {
    "mechatroner/rainbow_csv",
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon"
    },
  }
}
