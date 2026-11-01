-- Code-aware text objects and motions (uses the `main` branch API, like treesitter.lua)
--   Select:  af/if = function, ac/ic = class, aa/ia = argument/parameter
--            use with any operator: vaf, dif, cia, yac ...
--   Move:    ]f/[f = next/prev function start, ]k/[k = next/prev class start
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true, -- jump forward to the next match if the cursor isn't inside one
				selection_modes = {
					["@function.outer"] = "V", -- whole lines
					["@class.outer"] = "V",
				},
			},
			move = { set_jumps = true }, -- moves are added to the jumplist (<C-o> to go back)
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")

		local objects = {
			af = { "@function.outer", "Around function" },
			["if"] = { "@function.inner", "Inside function" },
			ac = { "@class.outer", "Around class" },
			ic = { "@class.inner", "Inside class" },
			aa = { "@parameter.outer", "Around argument" },
			ia = { "@parameter.inner", "Inside argument" },
		}
		for key, obj in pairs(objects) do
			vim.keymap.set({ "x", "o" }, key, function()
				select.select_textobject(obj[1], "textobjects")
			end, { desc = obj[2] })
		end

		local moves = {
			["]f"] = { "goto_next_start", "@function.outer", "Next function" },
			["[f"] = { "goto_previous_start", "@function.outer", "Previous function" },
			["]k"] = { "goto_next_start", "@class.outer", "Next class" },
			["[k"] = { "goto_previous_start", "@class.outer", "Previous class" },
		}
		for key, m in pairs(moves) do
			vim.keymap.set({ "n", "x", "o" }, key, function()
				move[m[1]](m[2], "textobjects")
			end, { desc = m[3] })
		end
	end,
}
