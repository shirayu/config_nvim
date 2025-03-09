require("general")
require("config.util")

require("config.lazy")

require("lazy").setup({
    { import = "plugins" },
})

load_lua_files_from("lang")
