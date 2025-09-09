local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Global leader mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)

map("n", "<leader>gs", "<cmd>Git<cr>", opts)
map("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", opts)
map("n", "<leader>gb", "<cmd>Git blame<cr>", opts)
map("n", "<leader>gl", "<cmd>Git log<cr>", opts)
map("n", "<leader>gp", "<cmd>Git push<cr>", opts)
map("n", "<leader>gP", "<cmd>Git pull<cr>", opts)

map("n", "<leader>ml", function()
	require("lint").try_lint()
end, { desc = "Lint file" })

map("n", "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "Formating file" })

require("config.lazy")

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

	sync_install = false,

	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = { "javascript" },

	highlight = {
		enable = true,
		disable = { "c", "rust" },
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		additional_vim_regex_highlighting = false,
	},
})

vim.diagnostic.config({
	virtual_text = true, -- show inline messages
	signs = true, -- show in the sign column
	underline = true, -- underline the text
	severity_sort = true, -- sort by severity
	float = {
		border = "rounded",
		source = "always",
	},
})

vim.o.number = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-t>", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", ":AvanteChatNew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-m>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
