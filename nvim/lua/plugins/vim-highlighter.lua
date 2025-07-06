-- plugins/vim-highlighter.lua
return {
	"azabiong/vim-highlighter",
	init = function()
		-- Key mappings configuration
		vim.g.HiSet = "f<CR>" -- f + Enter to set highlight
		vim.g.HiErase = "f<BS>" -- f + Backspace to erase highlight
		vim.g.HiClear = "f<C-L>" -- f + Ctrl+L to clear all highlights
		vim.g.HiFind = "f<Tab>" -- f + Tab to find patterns
		vim.g.HiSetSL = "t<CR>" -- t + Enter for positional highlight

		-- Jump key mappings for easy navigation
		vim.keymap.set("n", "gj", "<Cmd>Hi><CR>", { desc = "Jump to next highlight" })
		vim.keymap.set("n", "gk", "<Cmd>Hi<<CR>", { desc = "Jump to previous highlight" })
		vim.keymap.set("n", "gl", "<Cmd>Hi}<CR>", { desc = "Jump to next highlight position" })
		vim.keymap.set("n", "gh", "<Cmd>Hi{<CR>", { desc = "Jump to previous highlight position" })
		vim.keymap.set("n", "g<CR>", "<Cmd>Hi]<CR>", { desc = "Jump to next highlight by color" })
		vim.keymap.set("n", "g<BS>", "<Cmd>Hi[<CR>", { desc = "Jump to previous highlight by color" })

		-- Find key mappings for search navigation
		vim.keymap.set("n", "-", "<Cmd>Hi/next<CR>", { desc = "Next search result" })
		vim.keymap.set("n", "_", "<Cmd>Hi/previous<CR>", { desc = "Previous search result" })
		vim.keymap.set("n", "f<Left>", "<Cmd>Hi/older<CR>", { desc = "Older search" })
		vim.keymap.set("n", "f<Right>", "<Cmd>Hi/newer<CR>", { desc = "Newer search" })

		-- Command abbreviations for easier use
		vim.cmd("ca HL Hi:load")
		vim.cmd("ca HS Hi:save")

		-- Optional: Set sync mode (uncomment if needed)
		-- vim.g.HiSyncMode = 1

		-- Optional: Set directory to store highlight files
		-- vim.g.HiKeywords = '~/.config/keywords'
	end,
}
