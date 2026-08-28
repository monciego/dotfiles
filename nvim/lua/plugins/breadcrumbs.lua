local M = {
	"LunarVim/breadcrumbs.nvim",
	dependencies = {
		{ "SmiteshP/nvim-navic" },
	},
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	require("nvim-navic").setup({
		lsp = { auto_attach = true },
		highlight = true,
		depth_limit = 5,
		depth_limit_indicator = "…",
		safe_output = true,
	})

	require("breadcrumbs").setup()

	local exclude_ft = {
		"neo-tree",
		"lazy",
		"mason",
		"help",
		"alpha",
		"dashboard",
		"TelescopePrompt",
		"trouble",
	}

	vim.api.nvim_create_autocmd("FileType", {
		pattern = exclude_ft,
		callback = function()
			vim.opt_local.winbar = nil
		end,
	})
end

return M
