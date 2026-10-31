return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		options = {
			parsers = {
				hex = {
					default = true, -- #RGB, #RGBA, #RRGGBB, #RRGGBBAA, 0xAARRGGBB
					hash_aarrggbb = false, -- Clashes with #RRGGBBAA
					no_hash = false, -- Would match git hashes and random words
				},
				rgb = { enable = true },
				hsl = { enable = true },
				oklch = { enable = true },
				hwb = { enable = true },
				lab = { enable = true },
				lch = { enable = true },
				css_color = { enable = true },
				css_var = { enable = true },
				tailwind = { enable = true },
				sass = { enable = true, parsers = { css = true } },
				xterm = { enable = true },
				names = { enable = false }, -- Don't color words like "red" or "blue"
			},
			display = {
				mode = "virtualtext",
				virtualtext = {
					char = "󰝤", -- Nerd Font square (nf-md-square), sized to the text
					position = "before", -- Swatch in front of the color, like Zed
					hl_mode = "foreground",
				},
			},
		},
	},
	config = function(_, opts)
		-- colorizer always pads "before" swatches with a trailing space. Strip it
		-- so the swatch sits right against the color, like Zed.
		local ns = vim.api.nvim_create_namespace("colorizer")
		local set_extmark = vim.api.nvim_buf_set_extmark
		vim.api.nvim_buf_set_extmark = function(bufnr, ns_id, line, col, extmark_opts)
			if ns_id == ns and extmark_opts and extmark_opts.virt_text_pos == "inline" and extmark_opts.virt_text then
				local chunk = extmark_opts.virt_text[1]
				chunk[1] = chunk[1]:gsub(" $", "")
			end
			return set_extmark(bufnr, ns_id, line, col, extmark_opts)
		end

		require("colorizer").setup(opts)
	end,
}
