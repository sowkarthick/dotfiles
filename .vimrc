let mapleader      = ','
let maplocalleader = ','


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
Plugin 'VundleVim/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf.vim'
Plugin 'voldikss/vim-floaterm'
Plugin 'tpope/vim-commentary'
if has('nvim')
	Plugin 'neovim/nvim-lspconfig'
	Plugin 'hrsh7th/nvim-cmp'
    Plugin 'hrsh7th/cmp-buffer'
	Plugin 'hrsh7th/cmp-nvim-lsp'
	Plugin 'L3MON4D3/LuaSnip'
	Plugin 'saadparwaiz1/cmp_luasnip'
endif
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'

Plugin 'gruvbox-community/gruvbox'
   let g:gruvbox_contrast_dark = 'hard'


" Plugin 'fatih/vim-go'
call vundle#end()

let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'

set rtp+=~/.vim/bundle/YouCompleteMe

" File explorer
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>
nnoremap <f4> :sp<CR>
nnoremap <f5> :vsp<CR>
nnoremap <f6> :Explore<CR>
nnoremap <f7> :tabN<CR>
nnoremap <f8> :tabn<CR>
nnoremap <f3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <c-s> :w<cr>
nnoremap <c-q> :q<cr>

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" nnoremap <f12> :call system("xclip -selection clipboard", @@)<CR>
vmap <f12> y:call system("xclip -i -selection clipboard", getreg("\""))<cr>:call system("xclip -i", getreg("\""))<cr>
" nmap <S-f12> :call setreg("\"",system("xclip -o -selection clipboard"))<cr>p")")")"))


" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Show line numbers
set nu
" set relativenumber
set showmatch
set ruler

" Highlight line numbers
highlight LineNr ctermfg=LightGreen

" Status bar
set laststatus=2

"set showmode
"set showcmd

" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]

" 4 spaces to a tab
set tabstop=4
set shiftwidth=4
set expandtab
" allow toggling between local and default mode
function TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z
map <leader>p :%retab!<CR>

syntax on

" \l toggles tabs and EOL chars
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<CR>

" unhighlight after search
map <leader>; :noh<CR>

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
" augroup END

" Changes since last save
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

command Diff execute 'w !git diff --no-index % -'

" Update more often for vim-gitgutter "
set updatetime=100

" vim-gitgutter colours "
highlight clear SignColumn

" search highlight "
set hlsearch
hi Search ctermbg=LightGreen
hi search ctermfg=black

" NERDTree "
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" FZF "
" https://pragmaticpineapple.com/improving-vim-workflow-with-fzf/ "
" ----------------------------------------------------------------------------
" fzf.nvim
" ----------------------------------------------------------------------------
let $FZF_DEFAULT_OPTS .= ' --inline-info'

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git .ccls-cache install build --no-ignore . '.expand(<q-args>)
  \ })))

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

nnoremap <silent> <expr> ; (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>f        :History<CR>
nnoremap <silent> <Leader>h        :History:<CR>

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
    call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <Leader>r :RG <C-R><C-W><CR>


" }}}
" "
" ============================================================================
" " GUI {{{
" "
" ============================================================================
" " Enable 256 colors palette in Gnome Terminal
 if $COLORTERM == 'gnome-terminal'
     set t_Co=256
     endif
" colorscheme gruvbox
set background=dark

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Close the current buffer
if has('nvim')
    map <leader>bd :bd<cr>
else
    map <leader>bd :Bclose<cr>:tabclose<cr>gT
endif

" Quickly open a buffer for scribble
map <leader>e :e ~/buffer<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Vim commentary


" Vim Clipboard
" https://stackoverflow.com/questions/3961859/how-to-copy-to-clipboard-in-vim
" "*y -> copies to primary clipboard
" "+y -> copies to secondary clipboard
nnoremap Y "+y
vnoremap Y "+y
nnoremap yY ^"*y$
