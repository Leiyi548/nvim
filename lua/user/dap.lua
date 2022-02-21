builtin.plugins.dap_setting = {
 active = false,
 on_config_done = nil,
 breakpoint = {
  text = "",
  texthl = "LspDiagnosticsDefaultError",
  linehl = "DiffDelete", -- DiffChange
  numhl = "LspDiagnosticsDefaultError",
 },
 breakpoint_rejected = {
  text = "",
  texthl = "LspDiagnosticsSignHint",
  linehl = "",
  numhl = "",
 },
 stopped = {
  text = "",
  texthl = "DiagnosticFloatingInfo",
  linehl = "DiagnosticUnderlineInfo",
  numhl = "LspDiagnosticsSignInformation",
 },
}
vim.fn.sign_define("DapBreakpoint", builtin.plugins.dap_setting.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", builtin.plugins.dap_setting.breakpoint_rejected)
vim.fn.sign_define("DapStopped", builtin.plugins.dap_setting.stopped)

local dap, dapui = require("dap"), require("dapui")
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
