return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
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
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str
						end,
					},
				},
				lualine_b = {
					{ "branch", icon = "" },
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 1,
						symbols = {
							modified = " ",
							readonly = " ",
							unnamed = " Sem nome",
							newfile = " Novo",
						},
					},
				},
				lualine_x = {
					{
						function()
							local format = vim.bo.fileformat
							local icons = {
								unix = "",
								dos = "",
								mac = "",
							}
							return (icons[format] or "") .. " " .. format
						end,
						icons_enabled = true,
					},
					{ "encoding", icon = "" },
					{
						"filetype",
						icon_only = false,
						padding = { left = 1, right = 1 },
					},
				},
				lualine_y = { { "progress", icon = "", padding = { left = 1, right = 1 } } },
				lualine_z = { { "location", icon = "", padding = { left = 1, right = 1 } } },
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
	end,
}
