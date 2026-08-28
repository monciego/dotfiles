-- UI: General Display
vim.o.termguicolors = true -- Enable GUI colors for terminal
vim.o.cursorline = false -- Highlight the current line
vim.o.signcolumn = "yes:1" -- Always show sign column with width of 1
vim.o.number = true -- Show absolute line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.numberwidth = 4 -- Width of the number column
vim.wo.number = true -- Enable line numbers (window-local)
vim.o.winborder = "rounded" -- Use rounded borders for floating windows
vim.opt.fillchars = { eob = " " } -- Hide ~ characters on empty lines
-- vim.o.cmdheight = 0 -- Height of command line area
vim.opt.pumheight = 10 -- Maximum height of popup menu
vim.opt.ruler = true -- Show cursor position in command line

-- Scrolling & Wrapping
vim.o.wrap = false -- Don't wrap lines
vim.o.linebreak = true -- If wrapping, don't split words
vim.o.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.o.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.o.whichwrap = "bs<>[]hl" -- Allow these keys to move to next/prev line

-- Clipboard & Mouse
vim.schedule(function()
	vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim
end)
vim.o.mouse = "a" -- Enable mouse support

-- Tabs & Indentation
vim.o.tabstop = 2 -- Number of spaces per tab
vim.o.shiftwidth = 2 -- Number of spaces per indent
vim.o.softtabstop = 4 -- Editing operations count tab as 4 spaces
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Smarter auto-indenting
vim.o.autoindent = true -- Copy indent from current line

-- Search
vim.o.hlsearch = false -- Disable search highlight
vim.o.ignorecase = true -- Ignore case in search
vim.o.smartcase = true -- Override ignorecase if uppercase in search

-- Completion
vim.o.completeopt = "menuone,noselect" -- Better completion experience
vim.opt.shortmess:append("c") -- Don't show ins-completion-menu messages
vim.o.pumheight = 10 -- Popup menu height

-- Backup & Swap
vim.o.backup = false -- Disable backup files
vim.o.writebackup = false -- Disable write-backup
vim.o.swapfile = false -- Disable swapfile
vim.o.undofile = true -- Save undo history

-- Performance
vim.o.updatetime = 250 -- Faster update time
vim.o.timeoutlen = 300 -- Time to wait for mapped sequence

-- Command Line & Messages
vim.o.cmdheight = 0 -- Minimal command line height
vim.o.showmode = false -- Don't show mode (e.g., -- INSERT --)
vim.o.inccommand = "split" -- Live preview of :s command
vim.o.confirm = true -- Prompt to save before closing unsaved files

-- UI: Tabs & Status
vim.o.showtabline = 0 -- Always show tab line

-- File Encoding
vim.o.fileencoding = "utf-8" -- Use UTF-8 for file encoding

-- Backspace
vim.o.backspace = "indent,eol,start" -- Make backspace behave intuitively

-- Conceal & List Characters
vim.o.conceallevel = 0 -- Show all conceal syntax (e.g., `` in markdown)
vim.o.list = true -- Show invisible characters
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- Format Options
-- vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't auto-insert comment leaders

-- Keywords
vim.opt.iskeyword:append("-") -- Treat hyphenated-words as single word

-- Runtime Path (Optional Cleanup)
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate vim & neovim plugins

-- Filetype detection
vim.filetype.add({
	extension = {
		gotmpl = "gotmpl", -- Go templates (registered for gopls)
		tmpl = "gotmpl",
	},
	filename = {
		[".envrc"] = "sh", -- direnv files use bash syntax
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc", -- Treat tsconfig/jsconfig files as JSONC (allows comments)
	},
})
