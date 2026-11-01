-- Render markdown in the buffer: headings, bullets, checkboxes, tables, code blocks.
-- The line under the cursor shows raw markdown so you can still edit it.
return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		{ "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Toggle markdown rendering" },
	},
}
