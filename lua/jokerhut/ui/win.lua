local Win = {}

function Win.toggle(name, opts)
	Win._wins = Win._wins or {}

	local win = Win._wins[name]

	if not win or not win:valid() then
		win = require("snacks").win(opts)
		Win._wins[name] = win
	else
		win:toggle()
	end
end

return Win
