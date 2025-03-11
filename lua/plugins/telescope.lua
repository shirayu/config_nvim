return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      {

        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key",
              ["<esc>"] = actions.close,
            },
            n = { ["q"] = actions.close },
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
        },
      }
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-h>", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<C-g>", builtin.live_grep,  { desc = "Telescope live grep" })
    -- vim.keymap.set("n", "<leader>tb", builtin.buffers,    { desc = "Telescope buffers" })
    -- vim.keymap.set("n", "<leader>th", builtin.help_tags,  { desc = "Telescope help tags" })
  end
}
