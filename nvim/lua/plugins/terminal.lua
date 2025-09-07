return {
	{
		"rebelot/terminal.nvim",
		config = function()
			require("terminal").setup({
				-- Recommended defaults, tweak as needed
				layout = { open_cmd = "botright new" },
				cmd = nil, -- Default command is your shell
				autoclose = true,
			})

			-- Example keymaps
			vim.keymap.set("n", "<leader>tt", "<cmd>TerminalToggle<cr>", { desc = "Toggle terminal" })
			vim.keymap.set("n", "<leader>tn", "<cmd>TerminalNew<cr>", { desc = "New terminal" })
		end,
	},
}
