local function has_eslint_config()
	-- 检查常见 ESLint 配置文件名
	for _, config_file in ipairs({ ".eslintrc.js", ".eslintrc.json", ".eslintrc", ".eslintrc.yaml", ".eslintrc.yml" }) do
		if vim.fn.filereadable(config_file) == 1 then
			return true
		end
	end
	return false
end

if has_eslint_config() then
	vim.cmd(":EslintFixAll")
else
	print("未找到 ESLint 配置文件")
end
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
