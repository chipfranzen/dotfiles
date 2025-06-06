return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "bashls", "pyright", "ruff", "taplo" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "neovim/nvim-lspconfig",
        keys = {
          { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
          { "K", vim.lsp.buf.hover, desc = "Hover info" },
          { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
          { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
        },
        config = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    },
  },
}
