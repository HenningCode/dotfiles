local on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP rename" })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "LSP format file" })
    vim.keymap.set("n", "<leader>i", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "LPS enable inlay hints" })

    -- Telescope keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "LSP telescope open references" })
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    lazy = false,
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local cmp = require("cmp")

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
        -- lspconfig.eslint.setup({
            -- capabilities = capabilities,
            -- on_attach = on_attach,
        -- })
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.pyright.setup({
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
                    -- -- Add clippy lints for Rust.
                    -- checkOnSave = {
                    --     allFeatures = true,
                    --     command = "clippy",
                    --     extraArgs = {
                    --         "--",
                    --         "--no-deps",
                    --         "-Dclippy::correctness",
                    --         "-Dclippy::complexity",
                    --         "-Wclippy::perf",
                    --         "-Wclippy::pedantic",
                        -- },
                    -- },
                },
            },
        })

        cmp.setup({
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
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })
    end,
}
