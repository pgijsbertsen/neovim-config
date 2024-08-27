return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d > - <summary>",
      signs = {
        add          = { text = "┃ " },
        change       = { text = "┃ " },
        delete       = { text = "┃ " },
        topdelete    = { text = "┃ " },
        changedelete = { text = "" },
        untracked    = { text = "┃ " },
      }
    },
  },
}
