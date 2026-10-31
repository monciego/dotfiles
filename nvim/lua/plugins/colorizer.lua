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
					char = "■",
					position = "before", -- Swatch in front of the color, like VS Code
					hl_mode = "foreground",
				},
			},
		},
	},
}
