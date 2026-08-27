local api = vim.api

-- Don't auto-continue comments on new lines
api.nvim_create_autocmd("BufEnter", {
	command = [[set formatoptions-=cro]],
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restore cursor to the last position when opening a file
api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = api.nvim_buf_get_mark(0, '"')
		local line_count = api.nvim_buf_line_count(0)

		if mark[1] > 0 and mark[1] <= line_count then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Enable spell checking for text files
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.txt", "*.md", "*.tex" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en"
	end,
})

-- Close special buffers with <q>
api.nvim_create_autocmd("FileType", {
	group = api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"help",
		"qf",
		"checkhealth",
		"lspinfo",
		"notify",
		"man",
		"startuptime",
		"tsplayground",
		"spectre_panel",
		"neotest-output",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false

		vim.keymap.set("n", "q", "<cmd>close<CR>", {
			buffer = event.buf,
			silent = true,
			desc = "Close window",
		})
	end,
})
