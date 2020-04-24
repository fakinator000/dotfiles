
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
set list lcs=tab:\|\ 
set showbreak=↪\
set nu

" folding
set foldmethod=syntax
set foldclose=all
set foldnestmax=1
set foldminlines=10

" usefull

set inccommand=nosplit


" python paths pretty much
let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3.8'

" PLUG

call plug#begin('~/.neovim/plug')

  " programming
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}

  " utility
  Plug 'junegunn/fzf'
"  Plug 'scrooloose/nerdtree'
"  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tpope/vim-fugitive'
  Plug 'sirver/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'airblade/vim-gitgutter'

  " theming
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'endel/vim-github-colorscheme'

call plug#end()

" PLUGIN SETTINGS

" programming
let g:deoplete#enable_at_startup = 1

let g:LanguageClient_serverCommands = {
\'c': ['ccls'],
\'cpp': ['ccls', '--init={"clang":{"resourceDir":"/usr/lib/clang/10.0.0"}}'],
\'cuda': ['ccls'],
\'python':['$HOME/.local/bin/pyls'],
\'rust':['rustup', 'run', 'stable', 'rls'],
\'go':['gopls'],
\'tex':['texlab'],
\'js':['$HOME/npm/bin/javascript-typescript-langserver'],
\'html':['$HOME/npm/bin/html-languageserver', '--stdio'],
\'php':['php','vendor/felixfbecker/language-server/bin/php-language-server.php'],
\}

let g:LanguageClient_loadSettings = 1

" utility

let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" theming
colorscheme ron


" BINDS/HOOKS (autocmd, map)

" FZF \q
nnoremap <leader>q :FZF<CR>

function SetLSPShortcuts()
	nnoremap <leader><F5> :call LanguageClient_contextMenu()<CR>
	nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
	nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
	nnoremap <leader>f :call LanguageClient#textDocument_formatting()<CR>
	nnoremap <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
	nnoremap <leader>x :call LanguageClient#textDocument_references()<CR>
	nnoremap <leader>a :call LanguageClient#workspace_applyEdit()<CR>
	nnoremap <leader>c :call LanguageClient#textDocument_completion()<CR>
	nnoremap <leader>h :call LanguageClient#textDocument_hover()<CR>
	nnoremap <leader>s :call LanguageClient#textDocument_documentSymbol()<CR>
	nnoremap <leader>m :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
	autocmd!
	autocmd FileType c,cc,cpp,go,h,hh,hpp,html,js,php,py,tex call SetLSPShortcuts()
	autocmd BufWritePre *.c,*.cc,*.cpp,*.go,*.h,*.hh,*.hpp,*.js,*.py,*.tex :call LanguageClient#textDocument_formatting()
augroup END

au BufRead,BufNewFile *.tex set filetype=tex

" autocmd vimenter * NERDTree

