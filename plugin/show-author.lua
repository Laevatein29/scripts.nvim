if vim.g.show_author then
	return
end

vim.g.show_author = true

vim.api.nvim_create_user_command("ShowAuthor", 'lua require("show-author").list()', {})
