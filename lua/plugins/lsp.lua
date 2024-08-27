return {
  {
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v4.x",
      lazy = true,
      config = false,
    },
    {
      "williamboman/mason.nvim",
      lazy = false,
      config = true,
    },

    -- Autocompletion
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
      },
      config = function()
        local cmp = require("cmp")
        local cmp_format = require('lsp-zero').cmp_format({ details = true })

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
          }),
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
          performance = {
            debounce = 0, -- default is 60ms
            throttle = 0, -- default is 30ms
          },
          formatting = cmp_format,
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
        })
      end,
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      cmd = { "LspInfo", "LspInstall", "LspStart" },
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
      },
      config = function()
        local lsp_zero = require("lsp-zero")

        local lsp_attach = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
          map("<leader>gr", require("telescope.builtin").lsp_references, "Goto References")
          map("<leader>gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
          map("<leader>go", require("telescope.builtin").lsp_type_definitions, "Type Definition")
          map("<leader>p", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
          map("<leader>P", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")
          map("<leader>Ps", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

          map("<leader>gf", vim.lsp.buf.format, "Format file")
          map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("ga", vim.lsp.buf.code_action, "Code Action")
        end

        lsp_zero.extend_lspconfig({
          sign_text = true,
          lsp_attach = lsp_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        require("mason-lspconfig").setup({
          ensure_installed = {
            "ansiblels",                       -- Ansible
            "bashls",                          -- Bash
            "bzl",                             -- Starlark
            "docker_compose_language_service", -- Docker Compose
            "gopls",                           -- GO
            "jinja_lsp",                       -- Jinja
            "lua_ls",                          -- Lua
            "basedpyright",                    -- Python
            "terraformls",                     -- Terraform
            "yamlls",                          -- YAML
          },
          handlers = {
            function(server_name)
              require("lspconfig")[server_name].setup({})
            end,
          },
        })
      end,
    },
  },
}
