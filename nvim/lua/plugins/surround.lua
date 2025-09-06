return {
	"kylechui/nvim-surround",
	version = "*", -- latest stable
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end,
}
