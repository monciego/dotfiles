-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("config.lazy")

-- Setup lazy.nvim plugins: every file in lua/plugins/ is loaded automatically
require("lazy").setup({
	{ import = "plugins" },
})
