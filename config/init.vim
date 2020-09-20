
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
set relativenumber

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
  Plug 'neovim/nvim-lsp'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'

  " utility
  Plug 'junegunn/fzf'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " theming
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'

  Plug 'luochen1990/rainbow'

  Plug 'morhetz/gruvbox'

call plug#end()

colorscheme gruvbox

set termguicolors
let g:rainbow_active = 1

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']


let g:diagnostic_enable_virtual_text = 1
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:completion_matching_ignore_case = 1

lua require('init').setup_nvim_lsp()

nnoremap <F2> :FZF<CR>

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

imap <F5> <C-R>=strftime("%c")<CR>

