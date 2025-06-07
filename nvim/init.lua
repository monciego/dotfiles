-- Load core configuration
require('core.options')
require('core.keymaps')

-- Setup lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    him.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim plugins
require("lazy").setup({
    require 'plugins.treesitter',
    require 'plugins.colortheme',
    require 'plugins.neotree',
    require 'plugins.bufferline',
    require 'plugins.lualine',
    require 'plugins.telescope',
    require 'plugins.whichkey',
    require 'plugins.alpha',
    require 'plugins.autosession',
    require 'plugins.dressing',
    require 'plugins.indent-blankline',
    require 'plugins.autocomplete',
    require 'plugins.autopairs',
 --   require 'plugins.lsp',
})

