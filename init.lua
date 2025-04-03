require("config.version_check")
require("config.general")
require("config.diagnostic")
require("config.key")
require("config.util")

require("config.lazy_nvim")

local plugins = {
  { import = "plugins" },
}
local opts = {
  lockfile = vim.fn.stdpath("config") .. "/lock/lazy-lock.json",
}
require("lazy").setup(plugins, opts)

load_lua_files_from("lang")
