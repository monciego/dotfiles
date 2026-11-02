return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline", -- source for : commands
		"hrsh7th/cmp-nvim-lsp", -- LSP completion source
		"hrsh7th/cmp-nvim-lua", -- Lua completion for neovim config
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		-- your own snippets: nvim/snippets/<filetype>.snippets or nvim/snippets/<filetype>/*.snippets (SnipMate format)
		require("luasnip.loaders.from_snipmate").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

		-- Emmet turns ANY word into a tag (e.g. "pkgm" -> <pkgm></pkgm>). Only keep its
		-- suggestions when the text is a real HTML tag or uses Emmet syntax (div.card, ul>li*3).
		local html_tags = {}
		for tag in ([[a abbr address article aside audio b blockquote body br button canvas caption code col
			dd details dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head
			header hr html i iframe img input label legend li link main mark meta nav ol optgroup option output
			p picture pre progress q s section select small source span strong style sub summary sup svg table
			tbody td template textarea tfoot th thead time title tr u ul video]]):gmatch("%S+") do
			html_tags[tag] = true
		end
		local function keep_lsp_entry(entry)
			local client = entry.source.source and entry.source.source.client
			if not client or client.name ~= "emmet_ls" then
				return true
			end
			local abbr = entry.completion_item.label or ""
			return html_tags[abbr] or abbr:find("[%.#>%+%*%[%]{}:@!%^]") ~= nil
		end

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				-- Add tab completion for snippets
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for autocompletion (ORDER MATTERS!)
			sources = cmp.config.sources({
				{ name = "nvim_lsp", entry_filter = keep_lsp_entry }, -- LSP completions (MOST IMPORTANT!)
				{ name = "luasnip" }, -- snippets
				{ name = "nvim_lua" }, -- lua completions for neovim config
			}, {
				{ name = "buffer" }, -- text within current buffer (fallback)
				{ name = "path" }, -- file system paths (fallback)
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					show_labelDetails = true,
				}),
			},
		})

		-- Command-line completion (searching '/', ':' commands) — not included in your config at all
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		})
	end,
}
