-- fortune printing (from vim-startify)

-- To add this to the footer, simply add the following lines to the config:
-- use {
--     'goolord/alpha-nvim',
--     config = function ()
--         require'alpha.themes.dashboard'.section.footer.val = require'alpha.fortune'()
--         require'alpha'.setup(require'alpha.themes.dashboard'.opts)
--     end
-- }

local list_extend = vim.list_extend

--- @param line string
--- @param max_width number
--- @return table
local format_line = function(line, max_width)
	if line == "" then
		return { " " }
	end

	local formatted_line = {}

	-- split line by spaces into list of words
	local words = {}
	local target = "%S+"
	for word in line:gmatch(target) do
		table.insert(words, word)
	end

	local bufstart = " "
	local buffer = bufstart
	for i, word in ipairs(words) do
		if (#buffer + #word) <= max_width then
			buffer = buffer .. word .. " "
			if i == #words then
				table.insert(formatted_line, buffer:sub(1, -2))
			end
		else
			table.insert(formatted_line, buffer:sub(1, -2))
			buffer = bufstart .. word .. " "
			if i == #words then
				table.insert(formatted_line, buffer:sub(1, -2))
			end
		end
	end
	-- right-justify text if the line begins with -
	if line:sub(1, 1) == "-" then
		for i, val in ipairs(formatted_line) do
			local space = string.rep(" ", max_width - #val - 2)
			formatted_line[i] = space .. val:sub(2, -1)
		end
	end
	return formatted_line
end

--- @param fortune table
--- @param max_width number
--- @return table
local format_fortune = function(fortune, max_width)
	-- Converts list of strings to one formatted string (with linebreaks)
	local formatted_fortune = { " " } -- adds spacing between alpha-menu and footer
	for _, line in ipairs(fortune) do
		local formatted_line = format_line(line, max_width)
		formatted_fortune = list_extend(formatted_fortune, formatted_line)
	end
	return formatted_fortune
end

local get_fortune = function(fortune_list)
	-- selects an entry from fortune_list randomly
	math.randomseed(os.time())
	local ind = math.random(1, #fortune_list)
	return fortune_list[ind]
end

-- Credit to @mhinz for compiling this list in vim-startify
-- Chinese text
local fortune_list = {
	{
		"天街小雨润如酥，草色遥看近却无。",
		"最是一年春好处，绝胜烟柳满皇都。",
		"- 北饮狂刀",
	},
	{
		"金鳞岂是池中物，一遇风云便化龙",
		"九霄龙吟惊天变，风云际会浅水游",
		"- 韩愈",
	},
	{
		"众里寻他千百度。蓦然回首，",
		"那人却在，灯火阑珊处。",
		"- 辛弃疾 ",
	},
	{
		"上联为：长涨长涨长长涨",
		"下联为：涨长涨长涨涨长。",
		"横解为：涨长长涨",
		"- 极品家丁",
	},
	{
		"上联是：海水潮。朝朝潮，朝潮潮落。",
		"下联对：浮云涨，长长涨，长涨长消",
		"- 极品家丁",
	},
	{ "鹤延千年寿，松龄万古春。", "- 极品家丁" },
	{ "自古美人如名将，不许人间见白头。", "- 极品家丁" },
	{ "一羊引两羔 两猪共一槽。", "- 极品家丁" },
	{ "暮晓春来迟，先于百花知。", "岁岁种桃花，开在断肠时。", "- 极品家丁" },
	{
		"素手青颜光华发，半世尘缘半世沙。",
		"我唤青天睁开眼，风霜怎奈并蒂花。",
		"- 极品家丁",
	},
	{
		"与君初相识，犹如故人归。",
		"我生君未生，君生我已老。",
		"双枝并为春，岁岁作年少",
		"- 极品家丁",
	},
	{ "记住也许只需一眼，而忘掉却要一生。 ", "- 极品家丁" },
}

--- @return table
--- @param max_width number optional
--- returns an array of strings
local main = function(max_width)
	max_width = max_width or 54
	local fortune = get_fortune(fortune_list)
	local formatted_fortune = format_fortune(fortune, max_width)

	return formatted_fortune
end

return main
