return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},

		-- mason-lspconfig is configured inside config() below instead of via
		-- `opts`, so we can share one server list with vim.lsp.enable()
		-- and disable automatic_enable explicitly (see notes below).
		"mason-org/mason-lspconfig.nvim",

		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"prettier",
					"stylua",
					"isort",
					"black",
					"pylint",
					"eslint_d",
					"php-cs-fixer",
					"phpstan",
					"markdownlint-cli2",
				},
			},
		},

		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- -----------------------------------------------------------------------
		-- Single source of truth: every server you want installed + enabled.
		-- -----------------------------------------------------------------------
		local servers = {
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"lua_ls",
			"graphql",
			"emmet_ls",
			"prismals",
			"pyright",
			"phpactor",
			"gopls",
			"clangd",
			"rust_analyzer",
			"astro",
		}

		-- -----------------------------------------------------------------------
		-- Mason: install the servers. automatic_enable = false because we call
		-- vim.lsp.enable() ourselves below — avoids two systems both trying to
		-- decide which servers get started.
		-- -----------------------------------------------------------------------
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_enable = false,
		})

		-- -----------------------------------------------------------------------
		-- LSP server configuration
		-- -----------------------------------------------------------------------

		-- Shared capabilities for every server (merges with per-server configs).
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})

		vim.lsp.config("tailwindcss", {
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
			},
		})

		-- Optional: delete this block if you don't want opinionated gopls settings.
		vim.lsp.config("gopls", {
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			settings = {
				gopls = {
					semanticTokens = true,
					gofumpt = true,
					staticcheck = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})

		-- Enable all servers listed above.
		vim.lsp.enable(servers)

		-- -----------------------------------------------------------------------
		-- LSP keymaps
		-- -----------------------------------------------------------------------

		local group = vim.api.nvim_create_augroup("UserLspConfig", {})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, opts)

				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, opts)

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				-- Native restart: `:LspRestart` is not guaranteed to exist across
				-- nvim-lspconfig versions on 0.11+. This works everywhere.
				vim.keymap.set("n", "<leader>rs", function()
					local clients = vim.lsp.get_clients({ bufnr = event.buf })
					for _, client in ipairs(clients) do
						client:stop(true)
					end
					vim.defer_fn(function()
						vim.cmd("edit")
					end, 200)
				end, opts)
			end,
		})

		-- -----------------------------------------------------------------------
		-- Diagnostics
		-- -----------------------------------------------------------------------

		vim.diagnostic.config({
			virtual_lines = false,
			virtual_text = true,
			update_in_insert = true,

			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
				},
				numhl = {
					[vim.diagnostic.severity.WARN] = "WarningMsg",
				},
			},
		})
	end,
}
