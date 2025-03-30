-- version check
local version = vim.version()
if version.major < 0 or (version.major == 0 and version.minor < 11) then
  error("Version error.\nCurrent version: " .. version.major .. "." .. version.minor .. "." .. version.patch)
end
