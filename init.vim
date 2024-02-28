"automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

"plugins here, coc for example
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdtree' |
	\Plug 'Xuyuanp/nerdtree-git-plugin' |
	\Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Yggdroot/indentLine' 
Plug 'itchyny/lightline.vim'
Plug 'fladson/vim-kitty'
Plug 'tomasr/molokai'
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

"customization
set number
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set noshowmode
set updatetime=100
set guifont=Fira\ Code/11/-1/5/50/0/0/0/1/0

"javascript folding
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"NERDTree configuration
"automatically close when NERDTree is the las buffer
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"disable NERDTree's help message
let NERDTreeMinimalUI = 1
"use nerdfonts
let g:NERDTreeGitStatusUseNerdFonts = 1

"keyboard shortcuts
nmap <F2> :NERDTreeToggle<CR>

"colorscheme
set termguicolors
colorscheme molokai
let g:molokai_original = 1
highlight! link SignColumn LineNr

"gitgutter configuration
let g:gitgutter_map_keys = 0

"lightline configuration
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'filetype': 'LightLineFiletype',
      \   'mode': 'LightLineMode',
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fileformat': 'LightLineFileformat',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\' && &readonly ? '⭤' : ''
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head() 
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp,*.js,*.py call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
let g:syntastic_javascript_checkers = ["eslint"]
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
