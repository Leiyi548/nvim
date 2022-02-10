local clipboardImg_status_ok, clipboardImg = pcall(require, "clipboard-image")
if not clipboardImg_status_ok then
	return
end

clipboardImg.setup({
	-- Default configuration for all filetype
	default = {
		img_dir = "img",
		img_dir_txt = "img",
		img_name = function()
			return os.date("%Y-%m-%d-%H-%M-%S")
		end, -- Example result: "2021-04-13-10-04-18"
		affix = "%s", -- Multi lines affix
	},
	-- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
	-- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
	-- Missing options from `markdown` field will be replaced by options from `default` field
	markdown = {
		-- String that sandwiched the image's path
		affix = "![](%s)",
	},
})
