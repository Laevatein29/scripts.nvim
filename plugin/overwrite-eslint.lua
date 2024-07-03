if vim.g.overwrite_eslint then return end

vim.g.overwrite_eslint = true

vim.api.nvim_create_user_command(
  "FixAll",                   --
  require "overwrite-eslint", -- Lua
  { nargs = "?" }             --
)

-- TODO: add eslint fix fun

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.vue",
    "*.js",
    "*.ts",
    "*.jsx",
    "*.tsx",
    "*.mjs",
  },
  command = ":FixAll",
})
--
-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "vue",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  callback = function() vim.b.autoformat = false end,
})
-- vim.api.nvim_create_user_command("ShowAuthor", 'lua require("show-author").list()', {})
