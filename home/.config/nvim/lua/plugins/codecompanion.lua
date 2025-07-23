return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        },
      },
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            opts = {
              stream = true,
            },
            env = {
              api_key = "cmd: cat ~/.config/openai.token",
            },
            schema = {
              model = {
                default = function()
                  return "gpt-4.1"
                end,
              },
            },
          })
        end,
      },
    })

    vim.keymap.set("n", "<leader>c", ":CodeCompanionChat<CR>", { noremap = true, silent = true })
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
