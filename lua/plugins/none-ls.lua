return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	keys = {
		{ "<leader>gf", vim.lsp.buf.format, desc = "Format file" },
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		mason_null_ls.setup({
			ensure_installed = {
				-- formatters
				"stylua", -- lua
				"terraform_fmt", -- terraform
				"shfmt", -- bash
				"gofumpt", -- go
				"yamlfmt", -- yaml
				"isort", -- python
				"black", -- python
				"codespell", -- spelling
				-- linters
				"ansiblelint", -- ansible
				"mypy", -- python
				"pylint", -- python
				"golangci_lint", -- go
				"semgrep", -- go, python
				"terraform_validate", --terraform
				-- code actions
				"gitsigns",
			},
		})

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions

		null_ls.setup({
			sources = {
				formatting.stylua,
				formatting.terraform_fmt,
				formatting.shfmt,
				formatting.gofumpt,
				formatting.yamlfmt,
				formatting.isort,
				formatting.black,
				formatting.codespell,

				diagnostics.ansiblelint,
				diagnostics.mypy,
				diagnostics.pylint,
				diagnostics.golangci_lint,
				diagnostics.semgrep,
				diagnostics.terraform_validate,

				code_actions.gitsigns,
			},
		})
	end,
}
