vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

-- TOGGLE TERMINAL --
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

-- ERROR DIAGNOSTIC ON CURSOR --
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })

-- JAVA CLASS WIZARD --
local new_java = require("new_java")
vim.keymap.set("n", "<leader>jc", new_java.new_java, { desc = "Create new Java type" })

-- MARKDOWN PREVIEW TOGGLE --
vim.keymap.set("n", "<leader>md", "<cmd>Markview splitToggle<CR>", { desc = "Toggle markdown preview split" })

-- MAVEN --
local maven = require("maven_runner")

vim.keymap.set("n", "<leader>mb", function()
	maven.run("mvn clean install", "mb")
end, { desc = "Maven build" })

vim.keymap.set("n", "<leader>mt", function()
	maven.run("mvn test", "mt")
end, { desc = "Maven test" })

vim.keymap.set("n", "<leader>mr", function()
	maven.run("mvn spring-boot:run", "mr")
end, { desc = "Maven run" })

vim.keymap.set("n", "<leader>mo", function()
	require("maven_runner").focus_any()
end, { desc = "Open Maven log" })

-- reopen alpha dashboard
vim.keymap.set("n", "<leader>db", function()
	-- if Alpha is already open, just refresh
	if vim.bo.filetype == "alpha" then
		vim.cmd("AlphaRedraw")
	else
		vim.cmd("Alpha")
	end
end, { desc = "Open Alpha dashboard" })

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Gradle: picker that opens existing log or launches if missing
vim.keymap.set("n", "<leader>gr", function()
	local runner = require("maven_runner")

	local items = {
		{ key = "1", label = "Gradle build (gb)", cmd = "./gradlew build" },
		{ key = "2", label = "Gradle test (gt)", cmd = "./gradlew test" },
		{ key = "3", label = "Gradle runClient (gc)", cmd = "./gradlew runClient" },
		{ key = "4", label = "Gradle runServer (gs)", cmd = "./gradlew runServer" },
		{ key = "5", label = "Gradle download sources (gS)", cmd = "./gradlew --refresh-dependencies" },
		{ key = "6", label = "Run LWJGL3  (gr)", cmd = "./gradlew lwjgl3:run" },
		{ key = "7", label = "Gradle genIntellijRuns (gi)", cmd = "./gradlew genIntellijRuns" },
	}

	vim.ui.select(items, {
		prompt = "Gradle task:",
		format_item = function(it)
			return it.label
		end,
	}, function(choice)
		if not choice then
			return
		end
		-- try to focus, but if nothing exists, run it
		local bufnr = runner.focus(choice.key)
		if not bufnr then
			runner.run(choice.cmd, choice.key)
		end
	end)
end, { desc = "Gradle: pick task (focus or run)" })

vim.keymap.set("n", "<leader>go", function()
	require("maven_runner").focus("gr")
end, { desc = "Open Gradle log" })

-- SYSTEM CLIPBOARD --
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- keep half-page jumps centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, center" })

-- keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, center" })

-- NAVIGATION --
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to left pane" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to below pane" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to above pane" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to right pane" })

-- COMPILER --
vim.keymap.set(
	"n",
	"<leader>c",
	"<cmd>CompilerOpen<cr>",
	{ noremap = true, silent = true, desc = "Open compiler menu" }
)
vim.keymap.set("n", "<leader>r", "<cmd>CompilerRedo<cr>", { noremap = true, silent = true, desc = "Redo last compile" })
vim.keymap.set(
	"n",
	"<leader>cr",
	"<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<cr>" .. "<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Compile, run, and show results" }
)
vim.keymap.set(
	"n",
	"<leader>co",
	"<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Toggle compiler results" }
)

-- CLOSE OTHER BUFFERS --
vim.keymap.set("n", "<leader>o", vim.cmd.only)

-- LEETCODE --
vim.keymap.set("n", "<leader>lc", "<cmd>Leet<CR>", { silent = true })
vim.keymap.set("n", "<leader>lcn", "<cmd>Leet list status=NOT_STARTED<CR>", { noremap = true, silent = true })
