return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>o", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
  },
  opts = {
    enable_git_status = true,
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    default_component_configs = {
      indent = {
        padding = 0,
        with_markers = true,
        with_expanders = true,
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        folder_empty_open = "",
        default = "󰈙",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "",
          deleted = "",
          modified = "",
          renamed = "➜",
          -- Status type
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
    window = {
      position = "float",
      width = 30,
      mappings = {
        ["<Space>"] = false,
        h = "parent_or_close",
        l = "child_or_open",
      },
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        visible = false,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        always_show = {
          ".env",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
        hide_by_name = {
          ".git",
        },
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
          vim.opt_local.foldcolumn = "0"
        end,
      },
    },
    commands = {
      system_open = function(state)
        vim.ui.open(state.tree:get_node():get_id())
      end,
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else                      -- if expanded and has children, seleect the next child
            if node.type == "file" then
              state.commands.open(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        else -- if has no children
          state.commands.open(state)
        end
      end,
    },
    autocmds = {
      neotree_refresh = {
        event = "TermClose",
        pattern = "*lazygit*",
        desc = "Refresh Neo-Tree sources when closing lazygit",
        callback = function()
          local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
          if manager_avail then
            for _, source in ipairs({ "filesystem", "git_status", "document_symbols" }) do
              local module = "neo-tree.sources." .. source
              if package.loaded[module] then
                manager.refresh(require(module).name)
              end
            end
          end
        end,
      },
    },
  },
}
