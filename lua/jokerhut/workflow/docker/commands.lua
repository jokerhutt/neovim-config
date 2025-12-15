local function log(msg)
	local dir = vim.fn.stdpath("state") .. "/logs"
	vim.fn.mkdir(dir, "p")

	local path = dir .. "/docker.log"
	local f = io.open(path, "a")
	if f then
		f:write(os.date("%F %T ") .. msg .. "\n")
		f:close()
	end
end

local M = {}

function M.load_docker_ps(run, win)
	local cmd = run("docker ps --format '{{.ID}}\t{{.Names}}\t{{.Image}}'")
	log("RUN CMD: " .. cmd)

	vim.fn.jobstart(cmd, {
		stdout_buffered = true,

		on_stdout = function(_, lines)
			log("STDOUT: " .. vim.inspect(lines))
			if lines and #lines > 0 then
				vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)
			end
		end,

		on_stderr = function(_, lines)
			log("STDERR: " .. vim.inspect(lines))
		end,

		on_exit = function(_, code)
			log("EXIT CODE: " .. code)
		end,
	})
end

function M.docker_restart(run, container_id)
	vim.fn.jobstart(run("docker restart " .. container_id))
end

function M.docker_logs(run, container_id, win)
	local cmd = run("docker logs -f " .. container_id)
	log("RUN LOGS: " .. cmd)

	vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, {
		"Streaming logs for " .. container_id,
		"",
	})

	vim.fn.jobstart(cmd, {
		stdout_buffered = false,

		on_stdout = function(_, lines)
			if not lines or #lines == 0 then
				return
			end

			vim.api.nvim_buf_set_lines(win.buf, -1, -1, false, lines)

			vim.schedule(function()
				if vim.api.nvim_win_is_valid(win.win) then
					local line_count = vim.api.nvim_buf_line_count(win.buf)
					vim.api.nvim_win_set_cursor(win.win, { line_count, 0 })
				end
			end)
		end,

		on_exit = function(_, code)
			log("LOGS EXIT: " .. code)
		end,
	})
end

function M.container_under_cursor(win)
	local line = vim.api.nvim_get_current_line()
	local id = line:match("^(%S+)")
	if not id then
		return nil
	end
	return { id = id }
end

return M
