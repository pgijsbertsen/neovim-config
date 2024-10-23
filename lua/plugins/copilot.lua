return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = { enabled = false },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<S-Tab>",
          },
          filetypes = {
            yaml = true,
          },
        },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    build = "make tiktoken",
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>gc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat", mode = "n" }
    },
  }
}
