call plug#begin()
" Project tree:
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Fuzzy search
Plug 'junegunn/fzf.vim'
source /usr/share/doc/fzf/examples/fzf.vim

" Completion plugin
Plug 'dense-analysis/ale'

" Format selected code with :FormatLines
Plug 'google/vim-maktaba'
Plug 'https://github.com/google/vim-codefmt'

" Start page
Plug 'https://github.com/mhinz/vim-startify'

" \hp to observe changed hunk
" ]c - next hunk; [c - prev hunt
" \hu - revert current hunk
Plug 'https://github.com/airblade/vim-gitgutter'

" File Structure
" may need universal-ctags instead of exuberant-ctags
Plug 'https://github.com/majutsushi/tagbar'

" Buffers management
" \be to observe buffers
Plug 'jlanzarotta/bufexplorer'

Plug 'preservim/nerdcommenter'

" Markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'https://github.com/lervag/vimtex'
Plug 'frazrepo/vim-rainbow'
Plug 'https://github.com/ap/vim-buftabline'

Plug 'romgrk/doom-one.vim'

Plug 'rust-lang/rust.vim'
" :TestNearest
Plug 'https://github.com/vim-test/vim-test'

Plug 'mbbill/undotree'

Plug 'https://github.com/vimpostor/vim-tpipeline'

Plug 'easymotion/vim-easymotion'
call plug#end()

syntax on
set number
set relativenumber
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set mouse=a
set colorcolumn=80
set foldlevel=99
set mouse=a

" case-insensitive search
set ignorecase
set smartcase
set hlsearch

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
:map <C-j> <Plug>(easymotion-overwin-f2)
:imap <C-j> <Esc><Plug>(easymotion-overwin-f2)

nnoremap <silent> <Plug>(ale_hover) :ALEHover<Return>
:nmap <silent> cp <Plug>(ale_hover)
nnoremap <silent> <Plug>(ale_gd) :ALEGoToDefinition<Return>
:nmap <silent> gd <Plug>(ale_gd)
:map <F3> <Plug>(ale_next_wrap)zz
:map <C-F3> <Plug>(ale_previous_wrap)zz<CR>
:nnoremap <C-F10> :TestNearest<CR>
:imap <C-F10> <Esc>:TestNearest<CR>
:imap <M-CR> <Esc>:ALECodeAction<CR>
:nnoremap <M-CR> :ALECodeAction<CR>
:imap <C-F6> <ESC>:ALERename<CR>
:nnoremap <C-F6> :ALERename<CR>

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

let g:rainbow_active = 1 " set rainbow brackets active everywhere

let test#neovim#term_position = "below"
let test#strategy = "neovim"

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

set termguicolors
set background=dark
colorscheme doom-one

