return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore = false,
			suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },

			session_lens = {
				picker = "telescope",
				load_on_setup = true,
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for cwd" })
		keymap.set(
			"n",
			"<leader>wf",
			"<cmd>Telescope session-lens search_session<CR>",
			{ desc = "Find/search a session" }
		)
	end,
}
