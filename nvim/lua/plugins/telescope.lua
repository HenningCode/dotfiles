return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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

			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("fzy_native")
			require("telescope").load_extension("smart_open")
		end,
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			vim.keymap.set("n", "<leader><leader>", function()
				require("telescope").extensions.smart_open.smart_open({
                    cwd_only = true,
                    filename_first = false
                })
			end, { noremap = true, silent = true })
		end,
		dependencies = {
			"kkharji/sqlite.lua",
		},
	},
}
