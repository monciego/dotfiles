-- Jump anywhere on screen: press s, type 1-2 chars of the target, then the label shown next to it
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = { enabled = false }, -- keep the normal f/F/t/T behavior
		},
	},
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
		-- Normal/operator only: visual S belongs to nvim-surround
		{ "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash select treesitter node" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Flash remote (e.g. yr<label>iw)" },
		{ "<C-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle Flash in / search" },
	},
}
