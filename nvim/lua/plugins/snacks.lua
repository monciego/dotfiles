-- Image preview in Neovim (uses Ghostty's Kitty graphics protocol)
-- - Opening an image file (png, jpg, gif, webp, svg, pdf, ...) shows the image instead of binary
-- - Images linked in markdown/html are rendered inline
-- - <leader>ip shows the image under the cursor in a floating window
-- Needs ImageMagick (`magick` or `convert`) to convert non-PNG formats.
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = { enabled = true },
	},
	keys = {
		{
			"<leader>ip",
			function()
				Snacks.image.hover()
			end,
			desc = "Image preview under cursor",
		},
	},
}
