-- Side-by-side git diffs, file history and a 3-way merge conflict view
return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	opts = {},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: uncommitted changes" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: current file history" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: repo history" },
		{ "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
	},
}
