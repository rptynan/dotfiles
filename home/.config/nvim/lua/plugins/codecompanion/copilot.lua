-- local copilot = require("copilot")

local M = {}

function M:init()
	-- Set custom node version for Copilot (node v22)
	vim.g.copilot_node_command = "/Users/richardtynan/.nvm/versions/node/v22.20.0/bin/node"

	-- No tabbing please
	vim.g.copilot_no_tab_map = true

	-- Use Ctrl-Y to accept suggestions.
	vim.keymap.set("i", "<C-Y>", 'copilot#Accept("\\<CR>")', {
		expr = true,
		replace_keycodes = false,
	})
	-- Use Ctrl-] to cycle through suggestions.
	vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
	-- Can't use C-[ for prev because of conflicting with escape.

	-- Use Ctrl-t to accept word by word.
	vim.keymap.set("i", "<C-t>", "<Plug>(copilot-accept-word)")
end

return M
