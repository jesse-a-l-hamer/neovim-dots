---@module 'lazy'

---@type LazyKeysSpec[]
return {
  {
    "<leader>aa",
    "<cmd>CodeCompanionActions<cr>",
    desc = "Actions Panel",
  },
  {
    "<leader>ac",
    "<cmd>CodeCompanionChat Toggle<cr>",
    desc = "Toggle Chat",
  },
  {
    "<leader>as",
    "<cmd>CodeCompanionChat Add<cr>",
    desc = "Send visual selection to chat buffer",
    mode = "v",
  },
  {
    "<leader>ai",
    "<cmd>CodeCompanion<cr>",
    desc = "Inline",
  },
  {
    "<leader>a:",
    "<cmd>CodeCompanionCmd<cr>",
    desc = "Command",
  },
  {
    "<leader>a.",
    "<cmd>CodeCompanionCLI<cr>",
    desc = "CLI",
  },
}
