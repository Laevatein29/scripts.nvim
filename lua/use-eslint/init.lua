local function FixAll()
  local eslint_exists = vim.fn.exists ":EslintFixAll"
  -- vim.notify("Hello from Lua!" .. eslint_exists, vim.log.levels.INFO)
  if eslint_exists > 0 then
    vim.notify("Eslint Fixed", vim.log.levels.INFO)
    vim.api.nvim_command ":EslintFixAll"
  else
    vim.notify("Eslint config is not found!", vim.log.levels.INFO)
  end
end

vim.api.nvim_create_user_command(
  "FixAll",       --
  FixAll,         -- Lua
  { nargs = "?" } --
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
