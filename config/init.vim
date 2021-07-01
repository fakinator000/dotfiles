
" nop for arrows
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
"inoremap <Up> <nop>
"inoremap <Down> <nop>
"inoremap <Left> <nop>
"inoremap <Right> <nop>

" usability
set tabstop=8
set shiftwidth=8
set softtabstop=8
set list lcs=tab:»\ ,trail:·
set showbreak=↪\
set nu
set relativenumber

" folding
set foldmethod=syntax
set foldclose=all
set foldnestmax=1
set foldminlines=10

" usefull

set inccommand=nosplit

" PLUG
let g:vimspector_enable_mappings = 'HUMAN'

call plug#begin('~/.local/share/nvim/plug')

" programming
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'puremourning/vimspector'

Plug 'ziglang/zig.vim'

Plug 'igankevich/mesonic'

Plug 'dylon/vim-antlr'

" utility
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/fzf'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-surround'


" theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

Plug 'luochen1990/rainbow'

Plug 'morhetz/gruvbox'
Plug 'victorze/foo'

call plug#end()

colorscheme gruvbox

set termguicolors
let g:rainbow_active = 1

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']



nnoremap <F11> :MesonInit build
nnoremap <F7> :make

let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:completion_matching_ignore_case = 1

"lua require'init'
"lua lsp= require'lspconfig'

lua <<EOF
lsp = require'lspconfig'
local callback = function()
	require'completion'.on_attach()
end

lsp.rust_analyzer.setup{on_attach=callback}
lsp.ccls.setup{on_attach=callback,
	setup = {
		ccls = {
			clang= {
				extraArgs = {"--gcc-toolchain=/usr"}
			} 
		}
	}
}
lsp.bashls.setup{on_attach=callback}
lsp.gopls.setup{on_attach=callback}
lsp.pyls.setup{on_attach=callback}
lsp.html.setup{on_attach=callback}
lsp.cssls.setup{on_attach=callback}
lsp.sumneko_lua.setup{on_attach=callback}

lsp.zls.setup{on_attach=callback}

print("LSP Loaded")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = true,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)


EOF


nnoremap <F2> :tabnew<CR>:FZF<CR>

" You can use other key to expand snippet.
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" Expand selected placeholder with <C-j> (see https://github.com/hrsh7th/vim-vsnip/pull/51)
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" Jump to the next placeholder with <C-l>
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

imap <expr> <Tab> pumvisible() ? "\<C-n>" : vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : "\<Tab>"
smap <expr> <Tab> pumvisible() ? "\<C-n>" : vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : vsnip#available(1) ? '<Plug>(vsnip-jump-prev)' : "\<Tab>"
smap <expr> <S-Tab> pumvisible() ? "\<C-p>" : vsnip#available(1) ? '<Plug>(vsnip-jump-prev)' : "\<Tab>"



set completeopt=menuone,noinsert,noselect
set shortmess+=c

set omnifunc=v:lua.vim.lsp.omnifunc

imap <F12> <C-R>=strftime("%c")<CR>

function! ClangFormat()
	let l:formatdiff = 1
	pyf /usr/share/clang/clang-format.py
endfunction

autocmd FileType c,cpp set comments-=://
autocmd FileType c,cpp set comments+=:///

autocmd FileType rust set tabstop=8

autocmd BufWrite *.cpp,*.c,*.h,*.rs,*.go,*.py,*.sh :Autoformat
"autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()

au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4


