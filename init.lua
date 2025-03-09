local function load_lua_files_from(dir)
    local luv = vim.loop
    local path = vim.fn.stdpath("config") .. "/lua/" .. dir
    local handle = luv.fs_scandir(path)

    if not handle then
        return
    end

    while true do
        local name = luv.fs_scandir_next(handle)
        if not name then
            break
        end

        if name:match("%.lua$") then
            local module_name = dir .. "." .. name:gsub("%.lua$", "")
            require(module_name)
        end
    end
end

require("general")

require("config.lazy")

require("lazy").setup({
    { "airblade/vim-gitgutter" },
    { "qpkorr/vim-renamer" },
    { import = "plugins" },
})

load_lua_files_from("lang")
