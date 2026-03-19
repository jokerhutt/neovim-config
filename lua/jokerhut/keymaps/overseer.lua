vim.keymap.set("n", "<leader>c", "<cmd>OverseerRun<cr>", { noremap = true, silent = true, desc = "Open task menu" })

vim.keymap.set("n", "<leader>oc", function()
	local overseer = require("overseer")
	local task = overseer.list_tasks({ recent_first = true })[1]
	if task then
		overseer.run_action(task, "open output")
	end
end, { noremap = true, silent = true, desc = "Show task output" })
