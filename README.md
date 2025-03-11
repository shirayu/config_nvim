
# NeoVimの設定

```bash
git clone git@github.com:shirayu/config_nvim.git ~/.config/nvim
sudo apt install fd-find ripgrep
```

## キーバインド

- `\c`: コメントイン・アウトの切り替え, 1行・複数行ともに利用可 (`numToStr/Comment.nvim`)
- `ctrl + f`: ファイラーのオン・オフ (`nvim-tree/nvim-tree.lua`)
- `\?`: キーバインドの確認 (`folke/which-key.nvim`)
- `sy`, `sp`: 外部ファイルを利用したYank, Paste (`vim-scripts/yanktmp.vim`)
- `Ctrl + i`: インデントガイドの表示切り替え

- `Shift + F`: 言語に応じたフォーマット
- `Shift + O`: JSONのKeySortありフォーマット

- バッファ操作
    - `Ctrl + p`, `\bp`: 前に
    - `Ctrl + n`, `\bn`: 次に
    - `\bc`: 閉じる
