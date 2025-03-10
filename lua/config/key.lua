-- トリプルESCでスペルチェックをオフに
vim.keymap.set("n", "<Esc><Esc><Esc>", ":set nospell<CR><Esc>", { silent = true })

-- Ctrl-zを無効化
vim.keymap.set("n", "<C-z>", "<nop>", { noremap = true, silent = true })

-- ダブルESCで検索ハイライトを無効化
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true })
