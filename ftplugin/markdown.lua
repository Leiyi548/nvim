function toggle_checkbox()
	local line = vim.fn.getline(".")
	-- 先匹配掉最前面的空白符
	-- 然后匹配 - 或者 +
	-- 再匹配空白符
	-- 然后匹配 [x]
	local pattern = "^(%s*[%-%+]%s*%[([%sx%-]?)%])"
	local checkbox, state = line:match(pattern)
	if not checkbox then
		return
	end
	local new_val = vim.trim(state) == "" and "[x]" or "[ ]"
	checkbox = checkbox:gsub("%[[%sx%-]?%]$", new_val)
	local new_line = line:gsub(pattern, checkbox)
	vim.fn.setline(".", new_line)
end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<cr>", "<cmd>lua toggle_checkbox()<cr> ", opts)

function add_task()
	local line = vim.fn.getline(".")
	local content = "- [ ]"
	-- 先匹配掉最前面的空白符
	-- 然后匹配 - 或者 +
	-- 再匹配空白符
	-- 然后匹配 [x]
	local pattern = "^(%s*[%-%+]%s*%[([%sx%-]?)%])"
	local checkbox, state = line:match(pattern)
	if not checkbox then
		return
	end
	local line_number = vim.fn.line(".")
	vim.fn.append(line_number, content)
	vim.fn.cursor(line_number + 1, 5)
	vim.cmd([[startinsert!]])
end
vim.api.nvim_set_keymap("n", "<leader><cr>", "<cmd>lua add_task()<cr> ", opts)
