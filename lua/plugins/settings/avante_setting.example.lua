-- Save as `avante_setting.lua`
--
-- See https://github.com/yetone/avante.nvim/wiki/Custom-providers

-- vim.fn.setenv("OPENAI_API_KEY", "DUMMY")

return {
  provider = "ollama",
  ollama = {
    model = "qwq:32b",
  },

  --   openai = {
  --     endpoint = "https://api.openai.com/v1",
  --     model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
  --     timeout = 30000,  -- timeout in milliseconds
  --     temperature = 0,  -- adjust if needed
  --     max_tokens = 4096,
  --   },

}
