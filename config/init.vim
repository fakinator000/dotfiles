
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

set list lcs=tab:\|\ 
set nu

call plug#begin('~/.neovim/plug')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
  Plug 'junegunn/fzf'
endif

let g:deoplete#enable_at_startup = 1

set hidden

let g:LanguageClient_serverCommands = {
\'c': ['ccls'],
\'cpp': ['ccls'],
\'cuda': ['ccls'],
\'python':['pyls'],
\}

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/vlad/.config/nvim/settings.json'

call plug#end()

