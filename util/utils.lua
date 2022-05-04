local M = {}
-- Judge file is exist?
function M.file_exists(path)
	local file = io.open(path, "rb")
	if file then
		file:close()
	end
	return file ~= nil
end

-- copy file
-- source: be copied file
-- destination: copy file destination
function M.copyfile(source, destination)
	print(destination)
	print(source)
	-- open file
	local sourcefile = io.open(source, "r")
	local destinationfile = io.open(destination, "w")
	destinationfile:write(sourcefile:read("*all"))
	-- close file
	sourcefile:close()
	destinationfile:close()
end

-- get today daily filename
function M.daily_name()
	local today = os.date("%W_%Y-%m-%d")
	return daily_path .. today .. ".md"
end
return M
