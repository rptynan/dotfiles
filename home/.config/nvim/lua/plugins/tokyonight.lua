return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		on_highlights = function(highlights, colors)
			-- Tabline is a little dark for my liking
			highlights.TabLine.bg = "#3f4365"
			highlights.TabLine.fg = "#8b92a1"
			highlights.TabLineFill.bg = "#3f4365"
			-- Floating windows (including cmp popup)
			highlights.NormalFloat = { bg = colors.black }
			highlights.FloatBorder = { fg = colors.blue, bg = colors.black }
		end,
	},
}
