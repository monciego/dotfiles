return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	main = "nvim-treesitter",

	dependencies = {
		"windwp/nvim-ts-autotag",
	},

	opts = {
		ensure_installed = {
			"bash",
			"c",
			"rust",
			"diff",
			"lua",
			"luadoc",
			"vim",
			"vimdoc",
			"query",
			"html",
			"java",
			"css",
			"scss",
			"javascript",
			"typescript",
			"tsx",
			"json",
			"prisma",
			"graphql",
			"svelte",
			"astro",
			"php",
			"go",
			"python",
			"sql",
			"markdown",
			"markdown_inline",
			"blade",
			"dockerfile",
			"yaml",
			"toml",
			"gitignore",
			"git_config",
		},
	},

	config = function(_, opts)
		local ts = require("nvim-treesitter")

		ts.setup(opts)

		-- Install any parsers not already present (replaces old auto_install/ensure_installed behavior).
		ts.install(opts.ensure_installed)

		-- Register tsx parser for typescriptreact filetype (same as before).
		vim.treesitter.language.register("tsx", "typescriptreact")
		-- Blade files often report filetype "blade"; ensure the parser maps correctly.
		vim.treesitter.language.register("blade", "blade")

		-- Enable highlighting + indentation per-buffer. This replaces the old
		-- highlight.enable/indent.enable options which no longer exist on `main`.
		local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			callback = function(args)
				local buf = args.buf
				local lang = vim.treesitter.language.get_lang(args.match) or args.match

				-- Only start if a parser is actually available for this language;
				-- avoids errors on filetypes with no treesitter parser at all.
				local ok_add = pcall(vim.treesitter.language.add, lang)
				if not ok_add then
					return
				end

				pcall(vim.treesitter.start, buf, lang)

				-- Treesitter-based indentation.
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Setup autotag separately (unchanged, independent of the highlight/indent rewrite).
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		})
	end,
}
