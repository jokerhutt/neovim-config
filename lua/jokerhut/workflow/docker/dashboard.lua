local win = require("jokerhut.ui.win")
local docker = require("jokerhut.workflow.docker.commands")

local Snacks = require("snacks")
local win = require("jokerhut.ui.win")
local docker = require("jokerhut.workflow.docker.commands")

local ok, ssh = pcall(require, "jokerhut.workflow.ssh.ssh")
if not ok then
	vim.notify("missing ssh.lua", vim.log.levels.WARN)
	return
end

local function make_runner(host)
	if host.docker_ssh then
		return function(cmd)
			return string.format(host.docker_ssh, cmd)
		end
	end

	return function(cmd)
		return cmd
	end
end

-- --- Docker manager UI
local function open_docker_manager(host)
	local run = make_runner(host)

	Snacks.win({
		title = "Docker @ " .. host.label,
		footer = "[l] logs   [r] restart   [q] quit",
		footer_pos = "center",
		height = 0.6,
		width = 0.7,
		border = "rounded",
		ft = "docker",
		keys = {
			q = "close",

			l = function(win)
				local c = docker.container_under_cursor(win)
				if c then
					docker.docker_logs(run, c.id, win)
				end
			end,

			r = function(win)
				local c = docker.container_under_cursor(win)
				if c then
					docker.docker_restart(run, c.id)
				end
			end,
		},

		on_buf = function(win)
			docker.load_docker_ps(run, win)
		end,
	})
end

vim.keymap.set("n", "<leader>od", function()
	local items = vim.tbl_values(ssh.hosts)

	vim.ui.select(items, {
		prompt = "Select Remote Device:",
		format_item = function(item)
			return item.label
		end,
	}, function(host)
		if host then
			open_docker_manager(host)
		end
	end)
end, { desc = "Docker manager (Snacks)" })
