set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub

" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)

" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.

" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.

" Plugin 'ascenator/L9', {'name': 'newL9'}

" Project tree:
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" Fuzzy search
" sudo apt-get install silversearcher-ag
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
Plugin 'https://github.com/junegunn/fzf.vim'

" Completion plugin
" python-language-server/flake8/autopep8 should be installed for each
" virtualenv
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" PEP8 on save
" Plugin 'https://github.com/tell-k/vim-autopep8'

" Start page
Plugin 'https://github.com/mhinz/vim-startify'

" \hp to observe changed hunk
Plugin 'https://github.com/airblade/vim-gitgutter'

" File Structure
Plugin 'https://github.com/majutsushi/tagbar'

" Buffers management
" \be to observe buffers
Plugin 'jlanzarotta/bufexplorer'

" Smart commenter
Plugin 'preservim/nerdcommenter'

Plugin 'vim-airline/vim-airline'

" Markdown support
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:

"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set number
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set splitbelow

set rtp+=~/.fzf

syntax on

" bindings
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>i
:nmap <c-t> :tabnew<CR>
:imap <c-t> <Esc>:tabnew<CR>i
:map <C-n> :NERDTreeToggle<CR>
:nmap <F8> :TagbarToggle<CR>
:map <A-1> :NERDTreeToggle<CR>
:map <A-7> :TagbarToggle<CR>
:map <A-f> :Ag 
:map <C-_> <plug>NERDCommenterToggle<CR>
:imap <C-_> <Esc><plug>NERDCommenterToggle<CR>i

" CoC bindings
:map <F3> <Plug>(coc-diagnostic-next-error)
:nmap <leader>rn <Plug>(coc-rename)
:xmap <leader>f  <Plug>(coc-format-selected)
:nmap <leader>f  <Plug>(coc-format-selected)
:nmap <silent> gd <Plug>(coc-definition)

" let g:autopep8_on_save = 1
" let g:autopep8_disable_show_diff = 1

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

set backspace=indent,eol,start

set t_Co=256

" CoC settings
command! -nargs=0 Format :call CocAction('format')

set updatetime=300

let g:NERDSpaceDelims = 1
let g:vim_markdown_conceal = 2

" highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray

" show open buffers as tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
