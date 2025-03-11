require("config.general")
require("config.key")
require("config.util")

require("config.lazy")

local plugins = {
  { import = "plugins" },
}
local opts = {
  lockfile = vim.fn.stdpath("config") .. "/lock/lazy-lock.json",
}
require("lazy").setup(plugins, opts)

load_lua_files_from("lang")
