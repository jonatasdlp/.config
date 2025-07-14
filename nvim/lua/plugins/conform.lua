return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		stop_after_first = true,
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua", stop_after_first = true },
			javascript = { "prettier", stop_after_first = true },
			swift = { "swiftformat", stop_after_first = true },
			ruby = { "rubyfmt", stop_after_first = true },
			sh = { "shellharden", stop_after_first = true },
			bazel = { "buildifier", stop_after_first = true },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500 },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}
