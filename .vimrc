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
Plugin 'dense-analysis/ale'

" Format selected code with :FormatLines
Plugin 'google/vim-maktaba'
Plugin 'https://github.com/google/vim-codefmt'

" Start page
Plugin 'https://github.com/mhinz/vim-startify'

" \hp to observe changed hunk
" ]c - next hunk; [c - prev hunt
" \hu - revert current hunk
Plugin 'https://github.com/airblade/vim-gitgutter'

" File Structure
Plugin 'https://github.com/majutsushi/tagbar'

" Buffers management
" \be to observe buffers
Plugin 'jlanzarotta/bufexplorer'

" Smart commenter
Plugin 'preservim/nerdcommenter'

" Markdown support
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'https://github.com/rhysd/vim-clang-format'
Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'https://github.com/kien/ctrlp.vim'

Plugin 'https://github.com/joshdick/onedark.vim'
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

" case-insensitive search
set ignorecase
set smartcase
set hlsearch

set rtp+=~/.fzf

syntax on

" bindings
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>i
:map <C-n> :NERDTreeToggle<CR>
:nmap <F8> :TagbarToggle<CR>
:map <C-_> <plug>NERDCommenterToggle<CR>
:imap <C-_> <Esc><plug>NERDCommenterToggle<CR>i

execute "set <M-1>=\e1"
nnoremap <M-1> :NERDTreeToggle<CR>

nnoremap <silent> <Plug>(ale_rename) :ALERename<Return>
:nmap <leader>rn <Plug>(ale_rename)
nnoremap <silent> <Plug>(ale_hover) :ALEHover<Return>
:nmap <silent> cp <Plug>(ale_hover)
nnoremap <silent> <Plug>(ale_gd) :ALEGoToDefinition<Return>
:nmap <silent> gd <Plug>(ale_gd)
:map <F3> <Plug>(ale_next_wrap)

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDSpaceDelims = 1

let g:vim_markdown_conceal = 2

" highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=black

let g:clang_format#code_style = "llvm"
let g:clang_format#detect_style_file = 1

let g:ale_completion_enabled = 1

set langmap=йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ\\;;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>$

set foldlevel=99

set t_Co=256
let g:onedark_termcolors=16
colorscheme onedark

