return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- load lazily
		config = function()
			require("Comment").setup({
				--[[ optional config ]]
				padding = true,
				sticky = true,
				toggler = {
					line = "gcc", -- line comment
					block = "gbc", -- block comment
				},
				opleader = {
					line = "gc", -- line comment in visual mode
					block = "gb", -- block comment in visual mode
				},
			})
		end,
	},
}
