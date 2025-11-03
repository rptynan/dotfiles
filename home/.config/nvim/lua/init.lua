require("config.lazy")

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

vim.opt.guifont = "Hack Nerd Font:h12"
vim.g.have_nerd_font = true
vim.opt.winborder = "rounded"

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		-- Only show virtual text for errors
		severity = { min = vim.diagnostic.severity.ERROR },
		spacing = 2,
	},
})
