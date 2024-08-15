return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "ansiblels",                          -- Ansible
        "bashls",                             -- Bash
        "bzl",                                -- Starlark
        "docker_compose_language_service",    -- Docker Compose
        "gopls",                              -- GO
        "jinja_lsp",                          -- Jinja
        "lua_ls",                             -- Lua
        "pyright",                            -- Python
        "terraformls",                        -- Terraform
        "yamlls",                             -- YAML
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)

      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
      map("gr", require("telescope.builtin").lsp_references, "Goto References")
      map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
      map("go", require("telescope.builtin").lsp_type_definitions, "Type Definition")
      map("<leader>p", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
      map("<leader>P", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")
      map("<leader>Ps", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

      map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
      map("K", vim.lsp.buf.hover, "Hover Documentation")
      map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
      map("gD", vim.lsp.buf.declaration, "Goto Declaration")
      map("ga", vim.lsp.buf.code_action, "Code Action")
    end
  })
  end
}
