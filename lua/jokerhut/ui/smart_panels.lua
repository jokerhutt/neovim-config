local M = {}

local registry = {}

function M.register(name, spec)
	registry[name] = spec
end

local function close_all_except(name)
	for n, spec in pairs(registry) do
		if n ~= name and spec.is_open() then
			pcall(spec.close)
		end
	end
end

function M.toggle(name)
	local spec = registry[name]
	if not spec then
		return
	end
	if spec.is_open() then
		pcall(spec.close)
	else
		close_all_except(name)
		pcall(spec.open)
	end
end

function M.open(name)
	local spec = registry[name]
	if not spec then
		return
	end
	if not spec.is_open() then
		close_all_except(name)
		pcall(spec.open)
	end
end

function M.close(name)
	local spec = registry[name]
	if spec and spec.is_open() then
		pcall(spec.close)
	end
end

return M
