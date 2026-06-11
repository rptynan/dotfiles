return {
	"tpope/vim-fugitive",
	dependencies = {
		-- For :GBrowse to open the current file on GitHub/GitLab/Bitbucket
		{ "tpope/vim-rhubarb" },
	},
	init = function()
		-- Make the fugitive status window a reasonable size.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				vim.cmd("resize 20")
			end,
		})
	end,
}
