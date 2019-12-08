
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
\'cpp': ['ccls'],
\'cuda': ['ccls'],
\'python':['pyls'],
\'rust':['rustup', 'run', 'stable', 'rls'],
\'go':['gopls'],
\'php':['~/.node_modules_global/bin/intelephense', '--stdio']
\}

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/vlad/.config/nvim/settings.json'


nnoremap <leader><F5> :call LanguageClient_contextMenu()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>

autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

autocmd vimenter * NERDTree


