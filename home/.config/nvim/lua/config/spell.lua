vim.opt.spelllang = { "en_gb", "en_us" }
vim.opt.spelloptions = "camel" -- camelCase words get checked split up
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add" -- in .config/nvim/

-- Turn on spell check for text files. Treesitter takes care of enabling it for other files, so it's scoped to just
-- things like comment blocks. See treesitter.lua for that.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text" },
	callback = function()
		vim.opt_local.spell = true
	end,
})
