local M = {}

M.setup = function()
	local status_ok, org_mode = pcall(require, "orgmode")
	if not status_ok then
		return
	end
	org_mode.setup({
		org_agenda_files = { "~/Dropbox/Orgzly/*" },
		org_default_notes_file = "~/Dropbox/Orgzly/refile.org",
		org_agenda_templates = {
			T = {
				description = "Todo",
				template = "* TODO %?\n  DEADLINE: %T",
				target = "~/Dropbox/Orgzly/todos.org",
			},
			w = {
				description = "Work todo",
				template = "* TODO %?\n  DEADLINE: %T",
				target = "~/Dropbox/Orgzly/work.org",
			},
		},
		mappings = {
			global = {
				org_agenda = "go",
				org_capture = "gC",
			},
			org = {
				org_toggle_checkbox = "g<cr>",
				-- org_cycle("gn"),
				org_global_cycle = "gN",
				org_timestamp_up = "+",
				org_timestamp_down = "-",
			},
		},
	})
end

return M
