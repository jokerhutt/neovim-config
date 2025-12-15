local M = {}

function M.iterm_tab(cmd)
	vim.fn.jobstart({
		"osascript",
		"-e",
		string.format(
			[[
      tell application "iTerm"
        tell current window
          create tab with default profile
          tell current session
            write text "%s"
          end tell
        end tell
      end tell
    ]],
			cmd
		),
	}, { detach = true })
end

return M
