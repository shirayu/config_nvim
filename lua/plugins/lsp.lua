-- https://note.tkancf.com/20250109082836

return {
    "williamboman/mason.nvim",
    dependencies = {
        "zapling/mason-lock.nvim",

        -- LSP config
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",

        -- 補完
        "hrsh7th/nvim-cmp", -- 補完エンジン本体
        "hrsh7th/cmp-nvim-lsp", -- LSPから提供される補完候補をnvim-cmpで利用
        "hrsh7th/cmp-buffer", -- 現在のバッファから補完
        "hrsh7th/cmp-path", -- ファイルシステムのパス補完
        "onsails/lspkind.nvim", -- 補完欄にアイコンを表示
    },
    event = "VeryLazy",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "biome", "pyright", "ruff", "lua_ls" }, -- 必要な LSP を指定
            automatic_installation = true, -- 未インストールの LSP を自動インストール
        })

        -- https://zenn.dev/soyukke/articles/dab7918b7ac80e
        local server_configs = {}

        local function setup_default(config)
            -- デフォルトの設定を追加
        end
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                local config = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                }

                -- 言語サーバーごとの設定関数を呼び出す
                if server_configs[server_name] then
                    server_configs[server_name](config)
                else
                    setup_default(config)
                end

                require("lspconfig")[server_name].setup(config)
            end,
        })

        vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

        -- :MasonLock Creates a lockfile that includes all currently installed packages
        -- :MasonLockRestore Re-installs all packages with the version specified in the lockfile
        require("mason-lock").setup({
            lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json", -- (default)
        })

        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.complete(),
                ["<C-d>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })

        -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        -- Set configuration for specific filetype.

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })

        -- https://github.com/onsails/lspkind.nvim?tab=readme-ov-file#option-2-nvim-cmp
        local lspkind = require("lspkind")
        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol", -- show only symbol annotations
                    maxwidth = {
                        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as
                        -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                        menu = 50, -- leading text (labelDetails)
                        abbr = 50, -- actual suggestion item
                    },
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function(entry, vim_item)
                        -- ...
                        return vim_item
                    end,
                }),
            },
        })
    end,
}
