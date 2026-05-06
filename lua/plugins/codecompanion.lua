---@module 'lazy'
---@module 'codecompanion'

---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    interactions = {
      chat = {
        adapter = {
          name = "opencode",
          model = "gemma4",
        },
        editor_context = {
          ["buffer"] = {
            opts = {
              -- Always sync the buffer by sharing its "diff"
              -- Choose "all" to share the entire buffer
              default_params = "diff",
            },
          },
        }
      },
      cli = {
        agent = "opencode",
        agents = {
          opencode = {
            cmd = "opencode",
            args = {},
            description = "OpenCode CLI",
            provider = "terminal",
          },
        },
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_tools = true,
          show_server_tools_in_chat = true,
          add_mcp_prefix_to_tool_names = false,
          show_result_in_chat = true,
          format_tool = nil,
          make_vars = true,
          make_slash_commands = true,
        },
      },
    },
  },
}
