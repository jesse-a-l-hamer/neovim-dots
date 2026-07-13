---@module 'lazy'

---@type LazyPluginSpec
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/styles/markdown.css")
    end,
}
