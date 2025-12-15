local win = require("jokerhut.ui.win")

-- Verify ssh.lua exists
local ok, ssh = pcall(require, "jokerhut.workflow.ssh.ssh")
if not ok then
	vim.notify("Missing ssh.lua", vim.log.levels.WARN)
	return
end

local function SSHIn(host)
	vim.cmd(("TermExec direction=float cmd='ssh %s'"):format(host.alias))
end

-- Leader + SL toggles view of ssh configs
vim.keymap.set("n", "<leader>sl", function()
	win.toggle("ssh", {
		title = "SSH Config",
		file = vim.loop.os_homedir() .. ssh.config_path,
		ft = "sshconfig",
		border = "rounded",
	})
end)

-- Leader + sh toggles list of ssh selections
vim.keymap.set("n", "<leader>sh", function()
	local items = vim.tbl_values(ssh.hosts)

	vim.ui.select(items, {
		prompt = "Select Remote Device:",
		format_item = function(item)
			return item.label
		end,
	}, function(choice)
		if choice then
			SSHIn(choice)
		end
	end)
end, { desc = "SSH into a remote device" })
