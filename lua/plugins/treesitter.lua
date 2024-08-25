return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    ensure_installed = {
      "bash",
      "go",
      "lua",
      "python",
      "vim",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
