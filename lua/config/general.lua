-- 行番号
vim.o.number = true

-- 起動時のメッセージを無効
vim.o.shortmess = vim.o.shortmess .. "I"

vim.g.netrw_dirhistmax = 0

vim.o.whichwrap = "b,s,h,l,<,>,[,]"

vim.o.foldlevel = 100
vim.o.foldenable = false

vim.o.swapfile = false
vim.o.viminfo = ""

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- スペルチェック設定
vim.opt.spelllang = { "en", "cjk" }
vim.opt.spell = true


-- 検索設定
vim.opt.ignorecase = true -- 大文字小文字を区別しない
vim.opt.smartcase = true  -- 検索文字に大文字がある場合は区別
vim.opt.incsearch = true  -- インクリメンタルサーチ
vim.opt.hlsearch = true   -- 検索結果をハイライト

-- 括弧のマッチング
vim.opt.showmatch = true
vim.opt.matchpairs:append("<:>") -- '<>'を括弧のペアに追加

-- バックスペースの設定
vim.opt.backspace = { "indent", "eol", "start" }

-- 先頭ゼロ付きの数値を10進数と認識
vim.opt.nrformats = ""

-- マウス無効
vim.opt.mouse = ""

-- カーソル行
vim.opt.cursorline = true
vim.cmd([[
      highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
      highlight CursorLine gui=underline guifg=NONE guibg=NONE
]])

-- Nfkc command
vim.api.nvim_create_user_command("Nfkc", function()
  local buf = vim.api.nvim_get_current_buf()
  local text = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")

  local result = vim.fn.system("perl -CSD -MUnicode::Normalize -pe '$_ = NFKC($_)'", text)

  if result then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n"))
  end
end, {})

-- ファイル更新通知
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File has been updated by another process!", vim.log.levels.WARN)
  end,
})

vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true
  -- virtual_text = true
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
  signs = true,
  severity_sort = true,
  underline = true,
  update_in_insert = false,
})
