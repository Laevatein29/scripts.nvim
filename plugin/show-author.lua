if vim.g.loaded_co_author then
	return
end

vim.g.loaded_co_author = true

require("show-author")
