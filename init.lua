require("general")

require("config.lazy")

require("lazy").setup({
    { "airblade/vim-gitgutter" },
    { "qpkorr/vim-renamer" },
    { import = "plugins" },
})
