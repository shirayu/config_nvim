
# NeoVimの設定

```bash
git clone git@github.com:shirayu/config_nvim.git ~/.config/nvim
sudo apt install fd-find ripgrep
```

## キーバインド

- Edit
    - `\c`: コメントイン・アウトの切り替え, 1行・複数行ともに利用可 (`numToStr/Comment.nvim`)
    - `sy`, `sp`: 外部ファイルを利用したYank, Paste (`vim-scripts/yanktmp.vim`)
- coc.nvim
    - `<space>a`: diagnosticsの表示
- Tools
    - `\?`: キーバインドの確認 (`folke/which-key.nvim`)
    - `ctrl + f`: ファイラーのオン・オフ (`nvim-tree/nvim-tree.lua`)
    - `Ctrl + i`: インデントガイドの表示切り替え
- Format
    - `Shift + F`: 言語に応じたフォーマット
    - `Shift + O`: JSONのKeySortありフォーマット
- telescope
    - `Ctrl + g`: Telescope live grep
    - `Ctrl + h`: Telescope find files
- バッファ操作
    - `Ctrl + p`, `\bp`: 前に
    - `Ctrl + n`, `\bn`: 次に
    - `\bc`: 閉じる
- Avante
    - `\aa`: サイドバーの表示
    - `\ar`: サイドバーの更新
    - `\af`: サイドバーのフォーカス切り替え
    - `\ae`: 選択したブロックの編集
