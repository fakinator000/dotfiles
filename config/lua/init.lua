
lsp = require('nvim_lsp')

local M = {}

function M.setup_nvim_lsp()
	local callback = function()
		require'completion'.on_attach()
		require'diagnostic'.on_attach()
	end
	lsp.rust_analyzer.setup{on_attach=callback}
	lsp.ccls.setup{on_attach=callback}
	lsp.bashls.setup{on_attach=callback}
	lsp.gopls.setup{on_attach=callback}
	lsp.pyls.setup{on_attach=callback}


	print("LSP Loaded")

end

return M

