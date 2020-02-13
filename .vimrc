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

" Haskell plugins:
" Plugin 'https://github.com/alx741/vim-hindent.git'

" Universal syntax checker:
Plugin 'https://github.com/vim-syntastic/syntastic.git'

" Project tree:
Plugin 'https://github.com/scrooloose/nerdtree'

" Fuzzy search
Plugin 'https://github.com/junegunn/fzf.vim'

" Completion plugin
Plugin 'https://github.com/roxma/nvim-yarp'
Plugin 'https://github.com/roxma/vim-hug-neovim-rpc'
Plugin 'https://github.com/Shougo/deoplete.nvim'

" PEP8 for syntastic
Plugin 'https://github.com/tell-k/vim-autopep8'

" Start page
Plugin 'https://github.com/mhinz/vim-startify'

" Shows VCS changes
Plugin 'https://github.com/mhinz/vim-signify'

" File Structure
Plugin 'https://github.com/majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:

"filetype plugin on
"
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

" hindent
let g:hindent_on_save=1
let g:hindent_command="~/.local/bin/hindent"

" syntastic
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

let g:deoplete#enable_at_startup = 1

let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff = 1

set backspace=indent,eol,start
