-- Load core configuration
require("core.options")
require("core.keymaps")
require("config.lazy")

-- Setup lazy.nvim plugins
require("lazy").setup({
	require("plugins.treesitter"),
	require("plugins.colortheme"),
	require("plugins.neotree"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.telescope"),
	require("plugins.whichkey"),
	require("plugins.alpha"),
	require("plugins.autosession"),
	require("plugins.dressing"),
	require("plugins.indent-blankline"),
	require("plugins.autocomplete"),
	require("plugins.autopairs"),
	require("plugins.comment"),
	require("plugins.todo-comments"),
	require("plugins.sorround"),
	require("plugins.lsp"),
	require("plugins.trouble"),
	require("plugins.formatting"),
	require("plugins.linting"),
	require("plugins.gitsigns"),
	require("plugins.lazygit"),
})
