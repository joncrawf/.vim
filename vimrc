set nocompatible
filetype off

if (has('nvim'))
  " show results of substition as they're happening
  " but don't open a split
  set inccommand=nosplit
endif

" Plugins"{{{
source ~/.vim/plugins.vim

" }}}
" Colour scheme settings"{{{
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if &term =~ '256color'
  " disable background color erase
  set t_ut=
endif

" enable 24 bit color support if supported
if (has('mac') && empty($TMUX) && has("termguicolors"))
  set termguicolors
endif

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" Need to find a better way
if (has("termguicolors"))
  set termguicolors
endif

let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
set background=dark
let g:one_allow_italics=1
syntax on
set t_Co=256
colorscheme one
let g:rehash256 = 1
highlight Comment cterm=italic
highlight htmlArg cterm=italic
highlight SpecialKey ctermbg=none ctermfg=8
highlight NonText ctermbg=none ctermfg=8

" }}}
" Vim settings"{{{
set autoindent
set autoread     " auto-reload buffers when files are changed on disk
set backspace=indent,eol,start
set cmdheight=1             " command bar height
set complete+=kspell
set cursorline
set diffopt+=vertical
set encoding=utf-8
set expandtab
set foldenable
set foldmethod=marker       " fold based on marker
set foldnestmax=10          " deepest fold is 10 levels
set grepprg=ag     " use ag as default for grep
set hidden                  " current buffer can be put into background
set history=100     " number of commands to keep in history
set hlsearch                " highlight search results
set ignorecase              " case insensitive searching
set incsearch               " set incremental search, like modern browsers
set infercase     " smarter case for autocompletion
set laststatus=2            " show the satus line all the time
set linebreak    " set soft wrapping
set list " toggle invisible characters
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set magic                   " Set magic on, for regex
set mat=2                   " how many tenths of a second to blink
set modelines=0
set mouse=a
set nobackup nowritebackup noswapfile     " No unnecessary backup files
set noerrorbells
set nolazyredraw            " don't redraw while executing macros
set nrformats=     " Treat all numerals as decimal
set number
set numberwidth=3     " Width of the number column
set path+=**     " Add file paths to vim for native 'fuzzy find'
set relativenumber
set ruler
set scrolloff=3             " lines of text around cursor
set shell=$SHELL
set shiftwidth=2
set showbreak=↪
set showcmd                 " show incomplete commands
set showmatch               " show matching braces
set showmode
set smartcase               " case-sensitive if expresson contains a capital letter
set smartindent
set so=7                    " set 7 lines to the cursors - when moving vertical
set softtabstop=2
set spelllang=en_gb     " Set default spell check to British English
set splitbelow     " New horizontal split opens to the bottom
set splitright     " New vertical split opens to the right
set t_vb=
set tabstop=2
set title                   " set terminal title
set tm=500
set ttyfast                 " faster redrawing
set undodir=~/.vim/_undo/     " Set the directory to keep the undo files
set undofile     " Set the use of undofiles, which keeps a history of the undos
set visualbell
set wildmenu                " enhanced command line completion
set wildmode=list:longest,full
set wrap         " turn on line wrapping
set wrapmargin=8 " wrap lines when coming within n characters from side

" dont save .netrwhist history
let g:netrw_dirhistmax=0

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

runtime macros/matchit.vim     " Allow vim to match more than just brackets
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " highlight conflicts

" }}}
" Mappings {{{
nnoremap ; :
vnoremap ; :
" Visually select the text that was last edited/pasted
nnoremap gV `[v`]
" Makes the dot command behave on a Visually selected line
vnoremap . :norm.<CR>
" Better start of line config
nnoremap 0 ^
" Remap to increase number by 1
noremap <C-z> <C-a>
" Allow star to go back to the first search term
nnoremap * *N
" enable . command in visual mode
vnoremap . :normal .<cr>
" Copy to system clipboard
vnoremap <C-c> "*y
nnoremap <C-p> :Files<cr>

" Have to use hjkl
nnoremap <Left> :echoe "Use h"<cr>
nnoremap <Right> :echoe "Use l"<cr>
nnoremap <Up> :echoe "Use k"<cr>
nnoremap <Down> :echoe "Use j"<cr>

" Allow j and k to move down wrapped lines
nnoremap j gj
nnoremap k gk

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>

" When scrolling through search finds, they will automatically center
" on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Do not show q: window
map q: :q

map :Vs :vs
map :Sp :sp

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" Leader mappings"{{{
let mapleader = ","
let g:mapleader = ","
" paste from system
nnoremap <leader>p :put =nr2char(10)<CR>"*p`[=`]`]
nnoremap <leader>a :Ack!<Space>
" Going back to the last spelling mistake and choosing the 1st option
nnoremap <leader>sp mz[s1z=`z
" search for word under the cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>
nnoremap <leader>re :call RenameFile()<cr>
" Indent all and return to current line
nnoremap <leader>ii mzgg=G`z
" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>
" diff window
nnoremap <leader>dt :windo diffthis<cr>
nnoremap <leader>do :windo diffo<cr>
" switch between current and last buffer
nmap <leader>. <c-^>
" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>qa :qa<cr>
nnoremap <leader>qq :Bdelete<cr>
nnoremap <leader>qqa :bufdo :Bdelete<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>vi :e ~/.vim/init.vim<cr>
nnoremap <leader>ex :Explore .<cr>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<cr>
map <C-n> :NERDTreeToggle<CR>
" Move workspace to current buffer pwd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR> " all buffers
nnoremap <leader>lcd :cd %:p:h<CR>:pwd<CR> " local buffers
" Mappings for the tmux runner plugin
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>sc :VtrSendCommand<cr>
nnoremap <leader>sf :VtrSendFile!<cr>
nnoremap <leader>cr :VtrClearRunner<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <C-a> :VtrSendLinesToRunner<cr>
vnoremap <C-a> :VtrSendLinesToRunner<cr>
nnoremap <leader>or :VtrOpenRunner { 'orientation': 'v', 'percentage': 20 }<cr>:VtrSendFile<cr>

nnoremap <leader>ga :Git add %:p<cr><cr>
nnoremap <leader>gs :Gstatus<cr>

map <Leader><Leader> <Plug>(easymotion-prefix)
"}}}
" Custom Functions"{{{
" Rename current file"{{{
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
" }}}
" }}}
" Auto commands"{{{
augroup vimrcEx
  autocmd!

  autocmd FocusLost * silent! wa
  autocmd FileType qf wincmd J

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd BufWritePre * StripWhitespace

  " Maps K to open vim help for the word under cursor when editing vim files
  autocmd FileType vim setlocal keywordprg=:help

  " Automatically wrap at 80 characters and enable spell check text and markdowns
  autocmd BufRead,BufNewFile *.txt,*.markdown setlocal textwidth=80
  autocmd FileType text,markdown setlocal spell
  autocmd FileType text,markdown hi clear SpellBad
  autocmd FileType text,markdown hi SpellBad cterm=underline
  autocmd FileType text,markdown set formatoptions+=t

  " Enable spellchecking for org files
  autocmd FileType org setlocal spell
  autocmd FileType org hi clear SpellBad
  autocmd FileType org hi SpellBad cterm=underline

  " Automatically wrap at 72 characters and spell check git commit messages
  "   autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit hi clear SpellBad
  autocmd FileType gitcommit hi SpellBad cterm=underline
  autocmd FileType gitcommit set formatoptions+=t

  " Mapping q to close and help manual whilst keeping the split open
  autocmd FileType help nnoremap q :bd<cr>

  " Run NeoMake on read and write operations
  autocmd BufReadPost,BufWritePost * Neomake
augroup END
" }}}
" Wildmenu completion"{{{
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX store
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
" }}}
" Plugin Settings"{{{

" Airline"{{{
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
" }}}
" Ack"{{{
if executable('rg')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
" }}}
" DelimitMate" {{{
"let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1
" }}}
" Deoplete"{{{
if has('nvim')
  let g:deoplete#enable_at_startup = 1
endif
" }}}
" EasyMotion"{{{
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_upper = 1
" }}}
" Fzf"{{{
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <C-x><C-k> fzf#complete('cat /usr/share/dict/words')

" Enable per-command history.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}
" Gutentags" {{{
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_generate_on_missing = 0
" }}}
" Neomake"{{{
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
" }}}
" Nerdtree"{{{
let NERDTreeShowHidden = 1
" }}}
" Rainbow Parens"{{{
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}
" Tmux navigator"{{{
let g:tmux_navigator_save_on_switch = 2
" }}}
" Ultisnips"{{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.vim/plugged/vim-snippets/UltiSnips']
" }}}
" Vim better whitespace"{{{
let g:better_whitespace_filetypes_blacklist=['markdown', 'md']
" }}}
" Vim sexp"{{{
let g:sexp_enable_insert_mode_mappings = 1
" }}}
" Vim tmux runner"{{{
let g:VtrUseVtrMaps = 1
let g:VtrGitCdUpOnOpen = 0
let g:VtrPercentage = 33
" }}}
" }}}
