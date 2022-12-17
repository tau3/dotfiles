set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
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
" may need universal-ctags instead of exuberant-crags
Plugin 'https://github.com/majutsushi/tagbar'

" Buffers management
" \be to observe buffers
Plugin 'jlanzarotta/bufexplorer'

Plugin 'preservim/nerdcommenter'

" Markdown support
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'https://github.com/rhysd/vim-clang-format'
Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'https://github.com/lervag/vimtex'
Plugin 'frazrepo/vim-rainbow'
Plugin 'https://github.com/ap/vim-buftabline'

" Plugin 'https://github.com/romgrk/doom-one.vim'
Plugin 'romgrk/doom-one.vim'

Plugin 'rust-lang/rust.vim'
" :TestNearest
Plugin 'https://github.com/vim-test/vim-test'

Plugin 'mbbill/undotree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

syntax on
set number
set relativenumber
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set mouse=a
set scrolloff=8
set colorcolumn=80
set foldlevel=99
set mouse=a

" case-insensitive search
set ignorecase
set smartcase
set hlsearch

set rtp+=~/.fzf

" bindings
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>
:map <C-n> :NERDTreeToggle<CR>
:nmap <F8> :TagbarToggle<CR>
:map <C-_> <plug>NERDCommenterToggle<CR>
:imap <C-_> <Esc><plug>NERDCommenterToggle<CR>i
nnoremap <M-1> :NERDTreeToggle<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-p> :Files<CR>

nnoremap <silent> <Plug>(ale_rename) :ALERename<Return>
:nmap <leader>rn <Plug>(ale_rename)
nnoremap <silent> <Plug>(ale_hover) :ALEHover<Return>
:nmap <silent> cp <Plug>(ale_hover)
nnoremap <silent> <Plug>(ale_gd) :ALEGoToDefinition<Return>
:nmap <silent> gd <Plug>(ale_gd)
:map <F3> <Plug>(ale_next_wrap)zz

" thanks, Primeagen
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv
nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
" TODO
nnoremap <leader>p "_dP 


" works only in neovim, too much struggle to make it work in vim 
:imap <C-Del> X<Esc>lbce
:imap <C-x> <Esc>ddi
:imap <C-H> <C-W>

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
let g:ale_linters = {'rust': ['analyzer', 'cargo']}

set langmap=йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ\\;;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>$

let g:vimtex_view_method = 'zathura'

" set rainbow brackets active everywhere
let g:rainbow_active = 1

let test#neovim#term_position = "below"
let test#strategy = "neovim"

set termguicolors
colorscheme doom-one

