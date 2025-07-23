return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "nvimtools/none-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  config = function()
    -- require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_enable = true,
      ensure_installed = { "ts_ls", "lua_ls", "gopls" },
    })

    -- 	dependencies = {
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.black,
      },
      -- auto-format on save
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    vim.lsp.config("ts_ls", {
      settings = {
        typescript = {
          tsserver_max_memory = "4096",
          -- inlay hints here might be good
        },
      },
    })
    vim.lsp.config("lua_ls", {})
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- gi for goto implemenation
    vim.keymap.set("n", "gI", vim.lsp.buf.type_definition, bufopts) -- gt for goto type
    vim.keymap.set("n", "<leader>o", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>u", vim.lsp.buf.code_action, bufopts)
    -- These work with typescript-tools, but ts_ls has built-in LspTypescriptSourceAction command instead.
    -- vim.keymap.set("n", "<leader>i", "<cmd>TSToolsOrganizeImports<CR>", bufopts)
    -- vim.keymap.set("n", "<leader>I", "<cmd>TSToolsAddMissingImports<CR>", bufopts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, bufopts)  -- search references
    vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, bufopts) -- see all diags
    vim.keymap.set("n", "D", vim.diagnostic.open_float, bufopts)       -- hover current diag
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)               -- hover general
    vim.keymap.set("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", bufopts)
    vim.keymap.set("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", bufopts)
  end,
}
