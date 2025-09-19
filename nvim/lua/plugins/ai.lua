return {
	-- CodeCompanion (Chat-like AI experience / many adapters)
	{
		"olimorris/codecompanion.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim", -- optional but useful
		},
		config = function()
			require("codecompanion").setup({
				-- minimal defaults; configure adapters below
				debug = false,
				strategies = {
					chat = { adapter = "openai" }, -- change to your adapter e.g. "ollama", "claude_code", "azure_openai", etc.
					inline = { adapter = "openai" },
				},
				-- optional: keymaps (you can change these)
				keymaps = {
					open_chat = "<leader>ac", -- open codecompanion chat buffer
					run_action = "<leader>ar", -- run selected action
					accept_suggestion = "<C-y>", -- accept inline suggestion (example)
				},
			})
		end,
	},

	-- Copilot Chat for Neovim
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optionally: "nvim-telescope/telescope.nvim", "hrsh7th/nvim-cmp" etc.
		},
		config = function()
			require("CopilotChat").setup({
				-- defaults are usually fine; you can customize UI, commands and layouts
				-- note: the plugin uses your GitHub token / Copilot auth under the hood
			})
			-- handy command / keymap examples:
			vim.api.nvim_set_keymap("n", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>cp", ":CopilotChatPanel<CR>", { noremap = true, silent = true })
		end,
	},
}
