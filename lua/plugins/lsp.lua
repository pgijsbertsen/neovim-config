return {
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
      { "nvimtools/none-ls.nvim"},
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
    },
    config = function()
      local nvim_lsp = require('lspconfig')
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local null_ls = require('null-ls')
      local mason_null_ls = require('mason-null-ls')

      -- Set default capabilities for LSP
      local lspconfig_defaults = nvim_lsp.util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- Setup LSP servers
      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "ansiblels",                       -- Ansible
          "bashls",                          -- Bash
          "docker_compose_language_service", -- Docker Compose
          "gopls",                           -- GO
          "helm_ls",                         -- K8s Helm Charts
          "jinja_lsp",                       -- Jinja
          "lua_ls",                          -- Lua
          "starpls",                         -- Starlark
          "terraformls",                     -- Terraform
          "yamlls",                          -- YAML
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            nvim_lsp[server_name].setup({})
          end,
        },
      })

      -- Setup formatting and diagnostics 
      mason_null_ls.setup({
        ensure_installed = {
          -- Formatters
          "ansible-lint",                    -- Ansible
          "yamllint",                        -- YAML
          "ruff",                            -- Python
          "shfmt",                           -- Shell
          "gofumpt",                         -- Go
          -- Diagnostic
          "mypy",                            -- Python
        },
        automatic_installation = true,
      })

      local null_ls_sources = {
        null_ls.builtins.formatting.mypy,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.yamllint,
      }

      null_ls.setup({
        debug = true,
        sources = null_ls_sources,
      })

      -- Setup keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)

          local telescope = require("telescope.builtin")
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("<leader>gd", telescope.lsp_definitions, "Goto Definition")
          map("<leader>gr", telescope.lsp_references, "Goto References")
          map("<leader>gi", telescope.lsp_implementations, "Goto Implementation")
          map("<leader>go", telescope.lsp_type_definitions, "Type Definition")
          map("<leader>p", telescope.lsp_document_symbols, "Document Symbols")
          map("<leader>P", telescope.lsp_workspace_symbols, "Workspace Symbols")
          map("<leader>Ps", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")

          map("<leader>gf", vim.lsp.buf.format, "Format file")
          map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
          map("gd", vim.lsp.buf.declaration, "Goto Declaration")
          map("ga", vim.lsp.buf.code_action, "Code Action")
        end
      })
    end
  },
}
