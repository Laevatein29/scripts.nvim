if vim.g.show_todo then return end

vim.g.show_todo = true

vim.api.nvim_create_user_command("ShowTodo", 'lua require("add-todo").todo()', {})
