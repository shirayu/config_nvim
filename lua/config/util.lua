-- Preserve function in Lua
function Preserve(command)
    -- Save the last search.
    local search = vim.fn.getreg('/')
    -- Save the current cursor position.
    local cursor_position = vim.fn.getpos('.')
    -- Save the current window position.
    vim.cmd('normal! H')
    local window_position = vim.fn.getpos('.')

    -- Restore the cursor position before running the command.
    vim.fn.setpos('.', cursor_position)

    -- Execute the command.
    vim.cmd(command)

    -- Restore the last search.
    vim.fn.setreg('/', search)

    -- Restore the previous window position.
    vim.fn.setpos('.', window_position)
    vim.cmd('normal! zt')

    -- Restore the cursor position.
    vim.fn.setpos('.', cursor_position)
end

-- ExecForTexts function in Lua
function ExecForTexts(command, args)
    -- Check if the command is executable
    if vim.fn.executable(command) == 1 then
        Preserve(':silent %!' .. command .. ' ' .. args)
    else
        -- Show error message if command is not found
        vim.api.nvim_echo({ { command .. ' not installed!' } }, true, { guifg = '#FF0000' })
    end
end

function load_lua_files_from(dir)
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
