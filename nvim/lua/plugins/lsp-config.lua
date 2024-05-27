local on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    vim.keymap.set("n", "<leader>i", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, {})

    -- Telescope keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
    vim.keymap.set("n", "<leader>gD", builtin.diagnostics, {})
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    lazy = false,
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        require("mason").setup()
        require("fidget").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls" },
        })

        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Add clippy lints for Rust.
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = {
                            "--",
                            "--no-deps",
                            "-Dclippy::correctness",
                            "-Dclippy::complexity",
                            "-Wclippy::perf",
                            "-Wclippy::pedantic",
                        },
                    },
                },
            },
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                documentation = {
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                },
                completion = {
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
            }),
        })
    end,
}
