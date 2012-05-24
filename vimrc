" vgod's vimrc
" Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>
" Fork me on GITHUB  https://github.com/vgod/vimrc

" read https://github.com/vgod/vimrc/blob/master/README.md for more info

" For pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" General Settings
set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside
set showcmd             " show the enter command
set cursorline          " highlight current line
set nowrap              " donot wrap line
set confirm             " ask instead of just print errors
set noshowmode          " do not show mode, it is already in status line
set showmatch		" Cursor shows matching ) and }
set autoindent		" auto indentation

set incsearch		" incremental search
set nobackup		" no *~ backup files
set hlsearch		" search highlighting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise

set clipboard=unnamed	" yank to the system register (*) by default
set copyindent		" copy the previous indentation on autoindenting

set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu


syntax on		" syntax highlight
filetype on             " Enable filetype detection
filetype indent on      " Enable filetype-specific indenting
filetype plugin on      " Enable filetype-specific plugins


" auto reload vimrc when editing it
" autocmd! bufwritepost .vimrc source ~/.vimrc



if has("gui_running")	" GUI color and font settings
    set guioptions-=T	" hide the toolbar
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=b
    set guioptions-=m 	" remove the menu bar

    set guifont=Pragmata\ Italic\ 8
    set lines=35	" window height
    set columns=185	" window width
    
    colors nucolor      " color scheme, donot change the order
    set t_Co=256        " 256 color mode
else
    set term=linux      " set terminal mode

    imap OA <ESC>ki
    imap OB <ESC>ji
    imap OC <ESC>li
    imap OD <ESC>hi

    nmap OA k
    nmap OB j
    nmap OC l
    nmap OD h
    nmap ^[[8~ <End>
    imap ^[[8~ <End>
    nmap ^[[7~ <Home>
    imap ^[[7~ <Home>
    nmap <ESC>[8~ <End>
    imap <ESC>[8~ <End>
    nmap <ESC>[7~ <Home>
    imap <ESC>[7~ <Home>

    colors vgod
endif

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc,*.fifo,*.xz,*.zip,*.rar,*.gz,*.bz2

" Disable sound on errors{
    set novisualbell
    set noerrorbells
    set t_vb=
    set tm=500
" }

" TAB setting{
"    set expandtab        "replace <TAB> with spaces
    "set softtabstop=4 
"    set shiftwidth=4 

    "au FileType Makefile set noexpandtab
"}      							

" Status line{
    source ~/.vim/status.vim
" }

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
    let s:word = input("Replace \"" . expand('<cword>') . "\" with:") 
    :exe '%s/\<' . expand('<cword>') . '\>/' . s:word . '/g' 
    :unlet! s:word 
endfun 

fun! Maketags()
    :lcd %:p:h
    
    if &filetype == "cpp" || &filetype == "h" || &filetype == "c"
        :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
    else
        :!ctags -R --extra=+q .
    endif
endfun


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 

inoremap <A-q> <ESC><ESC>

" set leader to ,
let mapleader=","
let g:mapleader=","

" --- leader map bind{
    
    " show line number
    map <leader>n :set nu<CR>

    " ,/ turn off search highlighting
    nmap <leader>/ :nohl<CR>

    " replace the current word in all opened buffers
    map <leader>r :call Replace()<CR>

    " open the error console
    map <leader>ee :botright cope<CR> 
    " move to next error
    map <leader>] :cn<CR>
    " move to the prev error
    map <leader>[ :cp<CR>
" }

" --- move around splits {
    " move to and maximize the below split 
    map <C-J> <C-W>j<C-W>_
    " move to and maximize the above split 
    map <C-K> <C-W>k<C-W>_
    " move to and maximize the left split 
    nmap <c-h> <c-w>h<c-w><bar>
    " move to and maximize the right split  
    nmap <c-l> <c-w>l<c-w><bar>
    set wmw=0                     " set the min width of a window to 0 so we can maximize others 
    set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" --- move around tabs. conflict with the original screen top/bottom{
    " comment them out if you want the original H/L
    " go to prev tab 
    map <S-H> gT
    " go to next tab
    map <S-L> gt

    " new tab
    map <C-t><C-t> :tabnew<CR>
    " close tab
    map <C-t><C-w> :tabclose<CR> 
" }

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
    " Ctrl-u 1:    underline Parts w/ #'s
    noremap  <C-u>1 yyPVr#yyjp
    inoremap <C-u>1 <esc>yyPVr#yyjpA
    " Ctrl-u 2:    underline Chapters w/ *'s
    noremap  <C-u>2 yyPVr*yyjp
    inoremap <C-u>2 <esc>yyPVr*yyjpA
"}

"--------------------------------------------------------------------------- 
" PROGRAMMING SHORTCUTS
"--------------------------------------------------------------------------- 

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \	if &omnifunc == "" |
                \		setlocal omnifunc=syntaxcomplete#Complete |
                \	endif
endif

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 

" --- SuperTab
let g:SuperTabDefaultCompletionType = "context"

" --- TagBar
" toggle TagBar with F7
nnoremap <silent> <F7> :TagbarToggle<CR> 
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" --- NERDTree
"  toggle NERDTree with F8
nnoremap <silent> <F8> :lcd %:p:h<CR>:NERDTreeToggle<CR>

" --- TSelect
" toggle TSelect with <F2>
nnoremap <silent> <F2> <ESC>:TSelectBuffer<CR>

" --- Command-T
" toggle Command-T with <F3>
let g:CommandTMaxHeight = 15
" nnoremap <silent> <F3> <ESC><ESC>:CommandT<CR>

" --- Cscope
" add any datebase of cscope 
if has("cscope")
   source ~/.vim/cscope_maps.vim
endif

" --- OmniCppComplete
" close omni scratch preview
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

let OmniCpp_GlibalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1         " show function prototype (i.e. parameters) in popup window
let OmniCpp_MayCompleteDot = 1              " autocomplete with .
let OmniCpp_MayCompleteArrow = 1            " autocomplete with ->
let OmniCpp_MayCompleteScope = 1            " autocomplete with ::
let OmniCpp_SelectFirstItem = 2             " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2             " search namespaces in this and included files
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" --- map F12 to generate ctags for current folder:
autocmd Filetype * set tags=./tags,./TAGS
autocmd Filetype cpp,c,h call LoadCtags()
map <F12> :call Maketags()<CR>

func! LoadCtags()
    set tags+=~/.vim/tags/glib.tags
    set tags+=~/.vim/tags/gtk+.tags
    set tags+=~/.vim/tags/gdk.tags
endfun

" --- ShowMarks
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 

map <leader>mt :ShowMarksToggle<CR>
map <leader>mo :ShowMarksOn<CR>
map <leader>mh :ShowMarksClearMark<CR>
map <leader>ma :ShowMarksClearAll<CR>
map <leader>mm :ShowMarksPlaceMark<CR>

