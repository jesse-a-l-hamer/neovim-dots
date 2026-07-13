---@module 'lazy'

---@type LazyPluginSpec
return {
  "vyfor/cord.nvim",
  opts = {
    buttons = {
      label = "View Repository",
      url = function(opts)
        return opts.repo_url
      end,
    },
    display = {
      theme = "catppuccin",
      flavor = "accent",
    },
    text = {
      editing = function(opts)
        return "Editing " .. opts.filename
      end,
      workspace = function(opts)
        return "Project: " .. opts.workspace
      end,
      terminal = function(opts)
        return "In a terminal (" .. opts.name .. ")"
      end,
    },
  },
}
