-- Project-wide search and replace with live preview (uses ripgrep)
return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	opts = {},
	keys = {
		{ "<leader>sR", function() require("grug-far").open() end, desc = "Search & Replace in project" },
		{
			"<leader>sR",
			mode = "x",
			function() require("grug-far").with_visual_selection() end,
			desc = "Search & Replace selection",
		},
		{
			"<leader>sW",
			function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
			desc = "Search & Replace word under cursor",
		},
	},
}
