return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()
            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end

            vim.keymap.set("n", "<leader>e", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Open harpoon window" })
            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end, {})
            vim.keymap.set("n", "<leader>1", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<leader>2", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<leader>3", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<leader>4", function()
                harpoon:list():select(4)
            end)
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                        },
                    },
                },
            })
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

            require("telescope").load_extension("ui-select")
        end,
    },
}
