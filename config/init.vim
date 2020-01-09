
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>


set tabstop=8
set shiftwidth=8
set softtabstop=8

set list lcs=tab:\|\ 
set nu

let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3.8'

call plug#begin('~/.neovim/plug')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
  Plug 'junegunn/fzf'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
endif

call plug#end()

let g:deoplete#enable_at_startup = 1

set hidden

let g:LanguageClient_serverCommands = {
\'c': ['ccls'],
\'cpp': ['ccls', '--init={"clang":{"resourceDir":"/usr/lib/clang/9.0.1"}}'],
\'cuda': ['ccls'],
\'python':['pyls'],
\'rust':['rustup', 'run', 'stable', 'rls'],
\'go':['gopls'],
\}

let g:LanguageClient_loadSettings = 1


nnoremap <leader>q :FZF<CR>

function SetLSPShortcuts()
	nnoremap <leader><F5> :call LanguageClient_contextMenu()<CR>
	nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
	nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
	nnoremap <leader>f :call LanguageClient#textDocument_formatting()<CR>
	nnoremap <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
	nnoremap <leader>x :call LanguageClient#textDocument_references()<CR>
	nnoremap <leader>a :call LanguageClient_workspace_applyEdit()<CR>
	nnoremap <leader>c :call LanguageClient#textDocument_completion()<CR>
	nnoremap <leader>h :call LanguageClient#textDocument_hover()<CR>
	nnoremap <leader>s :call LanguageClient_textDocument_documentSymbol()<CR>
	nnoremap <leader>m :call LanguageClient_contextMenu()<CR>
	
	autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
	autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

endfunction()

augroup LSP
	autocmd!
	autocmd FileType c,cpp,go call SetLSPShortcuts()
augroup END

autocmd vimenter * NERDTree


