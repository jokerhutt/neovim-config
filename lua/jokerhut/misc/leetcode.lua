local ok, leet = pcall(require, "leetcode")
if not ok then
	return
end

leet.setup({
	lang = "java",
	picker = { provider = "telescope" },
	plugins = { non_standalone = true },
	description = { position = "left", width = "40%", show_stats = true },
	console = {
		open_on_runcode = true,
		dir = "row",
		size = { width = "90%", height = "75%" },
		result = { size = "60%" },
		testcase = { virt_text = true, size = "40%" },
	},
})
