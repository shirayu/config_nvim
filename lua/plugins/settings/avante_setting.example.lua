-- Save as `avante_setting.lua`
--
-- See https://github.com/yetone/avante.nvim/wiki/Custom-providers

-- vim.fn.setenv("OPENAI_API_KEY", "DUMMY")

return {
  providers = {
    ollama = {
      model = "qwq:32b",
    }
  },
}
