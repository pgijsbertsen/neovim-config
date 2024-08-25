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
			},
			config = function()
				local cmp = require("cmp")

				cmp.setup({
					sources = {
						{ name = "nvim_lsp" },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-u>"] = cmp.mapping.scroll_docs(-4),
						["<C-d>"] = cmp.mapping.scroll_docs(4),
					}),
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end,
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
				end

				lsp_zero.extend_lspconfig({
					sign_text = true,
					lsp_attach = lsp_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				})

				require("mason-lspconfig").setup({
					ensure_installed = {
						"ansiblels", -- Ansible
						"bashls", -- Bash
						"bzl", -- Starlark
						"docker_compose_language_service", -- Docker Compose
						"gopls", -- GO
						"jinja_lsp", -- Jinja
						"lua_ls", -- Lua
						"pyright", -- Python
						"terraformls", -- Terraform
						"yamlls", -- YAML
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
