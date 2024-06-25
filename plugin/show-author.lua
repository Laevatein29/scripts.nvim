local vim = require("vim")
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = {
		"*.vue",
		"*.js",
		"*.ts",
		"*.jsx",
		"*.tsx",
		"*.mjs",
	},
	command = ":EslintFixAll",
})

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
	callback = function()
		vim.b.autoformat = false
	end,
})
