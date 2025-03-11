return {
  {
    "numToStr/Comment.nvim",
    config = function()
      -- https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/
      vim.keymap.set("n", "<leader>c", ":normal gcc<CR><DOWN>", { desc = "Toggle comment line" })
      vim.keymap.set("v", "<leader>c", "<Esc>:normal gvgc<CR>", { desc = "Toggle comment block" })

      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
}
