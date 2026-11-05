-- Compile & run the current file in a tmux pane below Neovim (via vimux, also used by vim-test)
--   <leader>rr  save, compile and run the current file (C, Go, Rust)
--   <leader>rq  close the runner pane
-- Outside tmux it opens a terminal split instead.
--   C     cc -Wall -Wextra -g file.c -o /tmp/<name> && /tmp/<name>
--   Go    go run .        (inside a go.mod project)   | go run file.go
--   Rust  cargo run       (inside a Cargo project)    | rustc file.rs -o /tmp/<name> && /tmp/<name>
--
-- Adding a language: add an `elseif ft == "..."` branch in run_command() below (see the
-- examples at the end of it). Find the filetype name by opening a file of that language
-- and running :set ft?  (e.g. python, javascript, typescript, cpp, java, zig, lua).

local function project_root(marker, dir)
	local found = vim.fs.find(marker, { upward = true, path = dir })[1]
	return found and vim.fs.dirname(found)
end

local function run_command()
	local file = vim.fn.expand("%:p")
	local dir = vim.fn.expand("%:p:h")
	local name = vim.fn.expand("%:t:r")
	local bin = vim.fn.shellescape("/tmp/" .. name)
	local f = vim.fn.shellescape(file)
	local ft = vim.bo.filetype

	if ft == "c" then
		return dir, ("cc -Wall -Wextra -g %s -o %s -lm && %s"):format(f, bin, bin)
	elseif ft == "go" then
		if project_root("go.mod", dir) then
			return dir, "go run ."
		end
		return dir, "go run " .. f
	elseif ft == "rust" then
		local root = project_root("Cargo.toml", dir)
		if root then
			return root, "cargo run"
		end
		return dir, ("rustc %s -o %s && %s"):format(f, bin, bin)

	-- ── Add more languages here ──────────────────────────────────────────────
	-- Each branch returns two things:
	--   1. the folder to run in (`dir` = the file's folder, or a project root)
	--   2. the shell command to run
	-- Available variables:
	--   f    = full path to the file, already quoted   ('/home/you/code/hello.py')
	--   bin  = '/tmp/<name>', quoted, for compiled output
	--   dir  = the file's folder
	--   name = file name without extension            (hello)
	-- Uncomment or copy one of these:
	--
	-- Interpreted (just run the file):
	-- elseif ft == "python" then
	-- 	return dir, "python3 " .. f
	-- elseif ft == "javascript" then
	-- 	return dir, "node " .. f
	-- elseif ft == "typescript" then
	-- 	return dir, "bun " .. f
	-- elseif ft == "lua" then
	-- 	return dir, "lua " .. f
	--
	-- Compiled (build into /tmp, then run it):
	-- elseif ft == "cpp" then
	-- 	return dir, ("g++ -Wall -Wextra -std=c++20 -g %s -o %s && %s"):format(f, bin, bin)
	-- elseif ft == "zig" then
	-- 	return dir, "zig run " .. f
	--
	-- Project-aware (use the project's own runner when a marker file is found):
	-- elseif ft == "javascript" then
	-- 	local root = project_root("package.json", dir)
	-- 	if root then
	-- 		return root, "npm start"
	-- 	end
	-- 	return dir, "node " .. f
	end
end

local function run_file()
	local cwd, cmd = run_command()
	if not cmd then
		vim.notify("No run command for filetype '" .. vim.bo.filetype .. "'", vim.log.levels.WARN)
		return
	end
	vim.cmd("silent! write")
	local full = ("cd %s && clear && %s"):format(vim.fn.shellescape(cwd), cmd)

	if vim.env.TMUX then
		vim.fn.VimuxRunCommand(full)
	else
		vim.cmd("botright 15split | terminal " .. full)
	end
end

return {
	"preservim/vimux",
	keys = {
		{ "<leader>rr", run_file, desc = "Run current file" },
		{ "<leader>rq", "<cmd>VimuxCloseRunner<CR>", desc = "Close runner pane" },
	},
}
