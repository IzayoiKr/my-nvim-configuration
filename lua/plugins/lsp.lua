return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        -- Better Lua/Neovim API awareness
        "folke/lazydev.nvim",
    },
    config = function()
        -- ─────────────────────────────────────────────────────────────
        -- SNIPPETS
        -- ─────────────────────────────────────────────────────────────
        require("luasnip.loaders.from_vscode").lazy_load()

        -- ─────────────────────────────────────────────────────────────
        -- MASON
        -- ─────────────────────────────────────────────────────────────
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright",
                "ruff", -- Python
                "clangd", -- C/C++
                "gopls", -- Go
                "rust_analyzer", -- Rust
                "sqlls", -- SQL
                "ts_ls",
                "eslint", -- JavaScript/TypeScript
                "html", -- HTML
                "cssls",
                "tailwindcss", -- CSS
                "intelephense", -- PHP
                "lua_ls", -- Lua
                "jsonls",
                "yamlls", -- Data formats
                -- "marksman",              -- Markdown (uncomment if needed)
            },
        })

        -- ─────────────────────────────────────────────────────────────
        -- AUTOCOMPLETION (nvim-cmp)
        -- ─────────────────────────────────────────────────────────────
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lua" },
            },
        })

        -- ─────────────────────────────────────────────────────────────
        -- LSP — GLOBAL CONFIG (Neovim 0.11+ API)
        --
        -- vim.lsp.config('*', ...)       → applies to every server
        -- vim.lsp.config('name', ...)    → overrides a specific server
        -- vim.lsp.enable({...})          → activates servers
        --
        -- nvim-lspconfig still supplies default cmd / filetypes /
        -- root_markers for each server; we only specify what we change.
        -- ─────────────────────────────────────────────────────────────

        -- Broadcast nvim-cmp capabilities to every server automatically
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        -- ── Lua ───────────────────────────────────────────────────────
        -- lazydev.nvim handles Neovim API awareness without the heavy
        -- nvim_get_runtime_file("", true) workspace trick.
        require("lazydev").setup()

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim", "require" } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })

        -- ── Python ────────────────────────────────────────────────────
        vim.lsp.config("pyright", {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            init_options = {
                settings = { args = {} },
            },
        })

        -- ── C/C++ ─────────────────────────────────────────────────────
        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
            },
        })

        -- ── Go ────────────────────────────────────────────────────────
        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    analyses = { unusedparams = true },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })

        -- ── Rust ──────────────────────────────────────────────────────
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = { command = "clippy" },
                },
            },
        })

        -- ── TypeScript / JavaScript ───────────────────────────────────
        vim.lsp.config("ts_ls", {
            init_options = {
                preferences = {
                    importModuleSpecifierPreference = "relative",
                },
            },
        })

        -- ── HTML ──────────────────────────────────────────────────────
        vim.lsp.config("html", {
            filetypes = { "html", "blade" },
        })

        -- ── Tailwind CSS ──────────────────────────────────────────────
        vim.lsp.config("tailwindcss", {
            filetypes = {
                "html",
                "blade",
                "php",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
            },
        })

        -- ── PHP / Laravel ─────────────────────────────────────────────
        vim.lsp.config("intelephense", {
            filetypes = { "php", "blade" },
            settings = {
                intelephense = {
                    files = { maxSize = 5000000 },
                    environment = { phpVersion = "8.3" },
                    diagnostics = { enabled = true },
                    stubs = {
                        -- Core & stdlib
                        "core",
                        "standard",
                        "meta",
                        "superglobals",
                        -- Strings & encoding
                        "mbstring",
                        "iconv",
                        -- Date / time
                        "date",
                        -- Math
                        "bcmath",
                        "gmp",
                        -- Data formats
                        "json",
                        "xml",
                        "xmlreader",
                        "xmlwriter",
                        "simplexml",
                        "dom",
                        -- Regex & data structures
                        "pcre",
                        "spl",
                        -- Filesystem
                        "fileinfo",
                        "zip",
                        "zlib",
                        -- Networking & security
                        "curl",
                        "openssl",
                        "sockets",
                        "sodium",
                        "random",
                        -- Database (everything you'll hit with Laravel)
                        "pdo",
                        "pdo_mysql",
                        "pdo_sqlite",
                        "pdo_pgsql",
                        "mysqli",
                        "sqlite3",
                        -- Sessions, auth & filtering
                        "session",
                        "hash",
                        "filter",
                        -- Image
                        "gd",
                        -- CLI & process
                        "posix",
                        "pcntl",
                        "readline",
                        -- Reflection (handy for exploring Laravel internals)
                        "reflection",
                        -- Misc
                        "tokenizer",
                        "ctype",
                        "intl",
                        -- Frameworks
                        "laravel",
                        "wordpress",
                    },
                },
            },
        })

        -- ── Servers with no overrides (lspconfig defaults are fine) ───
        -- sqlls, eslint, cssls, jsonls, yamlls need no extra config.

        -- ── Enable all servers ────────────────────────────────────────
        vim.lsp.enable({
            "lua_ls",
            "pyright",
            "ruff",
            "clangd",
            "gopls",
            "rust_analyzer",
            "sqlls",
            "ts_ls",
            "eslint",
            "html",
            "cssls",
            "tailwindcss",
            "intelephense",
            "jsonls",
            "yamlls",
        })

        -- ─────────────────────────────────────────────────────────────
        -- KEYMAPS (on LSP attach)
        -- ─────────────────────────────────────────────────────────────
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
                end

                -- Navigation
                map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
                map("n", "K", vim.lsp.buf.hover, "LSP: Hover documentation")
                map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
                map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")
                map("n", "<leader>D", vim.lsp.buf.type_definition, "LSP: Type definition")
                map("n", "gr", vim.lsp.buf.references, "LSP: References")

                -- Workspace
                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "LSP: Add workspace folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "LSP: Remove workspace folder")
                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "LSP: List workspace folders")

                -- Actions
                map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
                map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
                map("n", "<leader>fo", function()
                    vim.lsp.buf.format({ async = true })
                end, "LSP: Format buffer")

                -- Diagnostics
                map("n", "[d", function()
                    vim.diagnostic.jump({ count = -1 })
                end, "LSP: Previous diagnostics")
                map("n", "]d", function()
                    vim.diagnostic.jump({ count = 1 })
                end, "LSP: Next diagnostics")
                map("n", "gl", vim.diagnostic.open_float, "LSP: Open diagnostic float")
            end,
        })

        -- ─────────────────────────────────────────────────────────────
        -- AUTOFORMAT ON SAVE
        -- ─────────────────────────────────────────────────────────────
        local autoformat_filetypes = {
            "lua",
            "python",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "html",
            "css",
            "json",
            "yaml",
            "markdown",
            "php",
        }

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                local bufnr = args.buf
                local filetype = vim.bo[bufnr].filetype

                if not vim.tbl_contains(autoformat_filetypes, filetype) then
                    return
                end

                vim.lsp.buf.format({
                    bufnr = bufnr,
                    formatting_options = {
                        tabSize = vim.bo[bufnr].shiftwidth,
                        insertSpaces = vim.bo[bufnr].expandtab,
                    },
                    -- ESLint is a linter, not a formatter — exclude it
                    filter = function(client)
                        return client.name ~= "eslint"
                    end,
                })
            end,
        })

        -- ─────────────────────────────────────────────────────────────
        -- DIAGNOSTICS
        -- ─────────────────────────────────────────────────────────────
        vim.diagnostic.config({
            -- virtual_lines (Neovim 0.10+): diagnostics appear on a dedicated
            -- line below the code — much cleaner than inline virtual_text
            virtual_text = false,
            virtual_lines = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })
    end,
}
