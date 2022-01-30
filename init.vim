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

call plug#end()

"customization
set number
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set noshowmode
set updatetime=100
"automatically start NERDTree with nvim
autocmd VimEnter * NERDTree
"automatically close when NERDTree is the las buffer
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"disable NERDTree's help message
let NERDTreeMinimalUI = 1
"keyboard shortcuts
"colorscheme
set termguicolors
colorscheme molokai
let g:molokai_original = 1
highlight! link SignColumn LineNr
