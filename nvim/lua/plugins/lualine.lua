return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
			},
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = {
				added = " ",
				modified = " ",
				removed = " ",
			},
			cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox_dark",
				section_separators = {
					left = "",
					right = "",
				},
				component_separators = {
					left = "",
					right = "",
				},
				disabled_filetypes = {
					"alpha",
					"Avante",
				},
				always_divide_middle = true,
				globalstatus = true,
			},

			sections = {
				lualine_a = { mode },

				lualine_b = {
					"branch",
					diff,
					diagnostics,
				},

				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},

				lualine_x = {
					diagnostics,
					{
						"encoding",
						cond = hide_in_width,
					},
					{
						"filetype",
						cond = hide_in_width,
					},
				},

				lualine_y = {
					"location",
				},

				lualine_z = {
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
				},
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					{
						"location",
						padding = 0,
					},
				},
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {},

			extensions = {
				"fugitive",
			},
		})
	end,
}
