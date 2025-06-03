-- Save as `avante_setting.lua`
--
-- See https://github.com/yetone/avante.nvim/wiki/Custom-providers

vim.fn.setenv("DUMMY_API_KEY", "DUMMY")

return {
  provider = "openrouter",
  providers = {
    openrouter = {
      __inherited_from = "openai",
      endpoint = "http://localhost:9090/v1",
      api_key_name = "DUMMY_API_KEY",
      model = "Qwen/QwQ-32B-GGUF:q4_k_m",
    },
  },
}
