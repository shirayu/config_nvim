-- トリプルESCでスペルチェックをオフに
vim.keymap.set("n", "<Esc><Esc><Esc>", ":set nospell<CR><Esc>", { silent = true })


-- ダブルESCで検索ハイライトを無効化
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true })


-- 無効化
vim.keymap.set("n", "<C-z>", "<nop>", { noremap = true, silent = true }) -- Ctrl-z
vim.keymap.set("n", "<C-e>", "<nop>", { noremap = true, silent = true }) -- Ctrl-e
vim.keymap.set("n", "<C-d>", "<nop>", { noremap = true, silent = true }) -- Ctrl-d
vim.keymap.set("n", "<C-n>", "<nop>", { noremap = true, silent = true }) -- Ctrl-n
