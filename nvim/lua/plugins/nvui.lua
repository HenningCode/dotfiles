return {
	{
		"nvchad/volt", -- optional, needed for theme switcher
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"nvchad/ui",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("nvchad").setup()
		end,
	},
	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
}
