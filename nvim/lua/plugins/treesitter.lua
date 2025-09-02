return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"swift",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"html",
				"css",
				"python",
				"c",
				"cpp",
				"rust",
				"go",
				"bash",
				"yaml",
				"markdown",
				"markdown_inline",
			},

			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
				},
			},
		})

		-- Optional: context at top of buffer
		require("treesitter-context").setup({
			enable = true,
			max_lines = 3,
			trim_scope = "outer",
		})
	end,
}
