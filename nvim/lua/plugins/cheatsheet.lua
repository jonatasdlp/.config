return {
	"sudormrfbin/cheatsheet.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
	},
	cmd = { "Cheatsheet", "CheatsheetEdit" }, -- load only when needed
	config = function()
		require("cheatsheet").setup({
			bundled_cheatsheets = {
				enabled = { "default", "unicode", "nerd-fonts" },
				disabled = {},
			},
			bundled_plugin_cheatsheets = {
				enabled = { "telescope.nvim", "plenary.nvim" },
				disabled = {},
			},
			-- you can add your own mappings
			include_only_installed_plugins = true,
		})
	end,
}
