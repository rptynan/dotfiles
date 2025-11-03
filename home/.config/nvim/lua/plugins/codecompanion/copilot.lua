-- local copilot = require("copilot")

local M = {}

function M:init()
	-- Set custom node version for Copilot (node v22)
	vim.g.copilot_node_command = "/Users/richardtynan/.nvm/versions/node/v22.20.0/bin/node"

	vim.keymap.set("i", "<C-Y>", 'copilot#Accept("\\<CR>")', {
		expr = true,
		replace_keycodes = false,
	})
	vim.g.copilot_no_tab_map = true
end

return M
