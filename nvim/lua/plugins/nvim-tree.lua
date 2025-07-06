return {
	"nvim-tree/nvim-tree.lua",
	version = "v1.23",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})
	end,
}
