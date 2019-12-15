
                 " ________________
                " |                |_____    __
                " |  My VimR:)     |     |__|  |_________
                " |________________|     |::|  |        /
   " /\**/\       |                \.____|::|__|      <
  " ( o_o  )_     |                      \::/  \._______\
   " (u--u   \_)  |
    " (||___   )==\
  " ,dP"/b/=( /P"/b\
  " |8 || 8\=== || 8
  " `b,  ,P  `b,  ,P
    " """`     """`

" Environment {

    set nocompatible
    set rtp+=/usr/local/opt/fzf

    call plug#begin('~/.config/nvim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'flazz/vim-colorschemes'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'w0rp/ale'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'ervandew/supertab'
    Plug 'majutsushi/tagbar'
    Plug 'mattn/emmet-vim'
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'easymotion/vim-easymotion'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'sebdah/vim-delve'
    Plug 'pangloss/vim-javascript'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'mhinz/vim-startify'
    Plug 'matze/vim-move'
    Plug 'junegunn/vim-easy-align'
    Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
    " Or install latest release tag
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
    " Or build from source code
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    call plug#end()
" }

" General {

    syntax on

    filetype plugin indent on                       " Turn on plugins

	set clipboard=unnamed 				            " Use (*) register for copy-paste
    set tabstop=4 									" All the tab characters entered will be changed to spaces
    set shiftwidth=4
    set expandtab 									" To insert space characters whenever the tab key is pressed

    set mouse=a                                     " Automatically enable mouse usage
    set mousehide                                   " Hide the mouse cursor while typing
    set laststatus=2                                " Always show the statusline
    set showcmd                                     " Show the enter command
    set cursorline                                  " Highlight current line
    set history=100                                 " Keep 100 lines of command line history
    set scrolloff=5                                 " Minimum lines to keep above and below cursor
    set nu 											" Show the line number
    set nowrap                                      " Do not wrap line
    set ruler                                       " Show line and column number
    set confirm                                     " Ask instead of just print error
    set showmatch                                   " Cursor show matching ) and }
    set autoindent                                  " Automatically indent
    set copyindent                                  " Copy the previous indentation on auto indenting
    set hidden                                      " Allow buffer switching without saving
    set nospell                                     " Disable spell checking
    set autoread                                    " Automatically read a file that has changed on disk
    set encoding=utf8                    		    " Set default encoding to UTF-8

    set nobackup                                    " No *~backup file
    set noswapfile                                  " No *.swp file

    set incsearch                                   " Incremental search
    set hlsearch                                    " Highlight search
    set ignorecase                                  " Ignore case when searching
    set smartcase                                   " Ignore case if search pattern is all lowercase, case-sensitive otherwise

    set wildchar=<TAB>                              " Start wild expansion in the command line using <TAB>
    set wildmenu                                    " Wild char completion menu

    set relativenumber
    set number

    set nolist
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

    set wildignore+=*.o,*.out,*.obj,*.git,*.rbc,*.rbo,*.class,.svn,*.gem
    set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
    set wildignore+=*.swp,*~,._*
" }

" Filetypes {

    if has ("autocmd")
        au Filetype make setlocal noexpandtab   " In makefiles, use real tabs, not tabs expanded to spaces

        au BufRead,BufNewFile {Gemfile,Rakefile,*.rake} setf ruby

        au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdb,txt} setf markdown

        au BufRead,BufNewFile *.json setf javascript
    endif

	autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufRead *.tag setlocal filetype=javascript
" }

" GUI {

" Appearance {
        set t_Co=256
        set background=light

        if has("gui_macvim") || has("gui_vimr")
            set guioptions-=T
            set guioptions-=m
            set guioptions-=L
            set guioptions-=l
            set guioptions-=R
            set guioptions-=r
            set guioptions-=b

            set lines=40
            set columns=166
        endif

        colorscheme palenight
    " }
" }

" Plugins {

	" NERDTree {
        let NERDChristmasTree = 1
        let NERDTreeShowBookmarks = 1
        let NERDTreeDirArrows = 0
        let NERDTreeHighlightCursorline = 1
        let NERDTreeShowLineNumbers = 0
        let NERDTreeIgnore = ['\~$', '\.o$', '\.obj$', '\.out$', '\.a$', '\.swp$', '\.pyc', '\.so$', '\.pyo$', '\.DS_Store$', 'node_modules', 'dist', '\.traineddata$', '\.lock$']
        let NERDTreeBookmarksFile = $HOME . "/.vim/NREDTreeBookmarks"
        let g:NERDTreeMinimalUI = 1
	" }

	" Ale {
        let g:ale_linters = {'go': ['golangci-lint'], 'javascript': ['eslint']}
        let g:ale_go_golangci_lint_package = 1
        let g:ale_go_golangci_lint_options = '--fast'
        let g:ale_javascript_prettier_use_local_config = 1
	" }

	" Python Mode {
		let g:pymode_folding = 0
		let g:pymode_rope = 0
	" }

	" Easy Align {
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap ga <Plug>(EasyAlign)
	" }

	" Vim Go {
        let g:go_fmt_fail_silently = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_extra_types = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_types = 1
        let g:go_version_warning = 0
        let g:go_auto_sameids = 0
        let g:go_addtags_transform = "camelcase"
        let g:go_fmt_command = "goimports"
        let g:go_info_mode='guru'
        let g:go_def_mode='gopls'
        let g:go_info_mode='gopls'

        au FileType go nmap <D-d> :GoDeclsDir<cr>
        au FileType go nmap <leader><leader>g <Plug>(go-def)
        au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
        au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
        au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
        au FileType go nmap <leader>gt :GoTest -short<cr>
        au FileType go nmap <leader>gg :GoCoverageToggle -short<cr>
	" }

	" Emmet {
		let g:user_emmet_expandabbr_key = '<Tab>'
		let g:use_emmet_complete_tag = 1
	" }

	" fzf {
        let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores --ignore .git -l -g ""'

        " [Buffers] Jump to the existing window if possible
        let g:fzf_buffers_jump = 1

        " [[B]Commits] Customize the options used by 'git log':
        let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

        " [Tags] Command to generate tags file
        let g:fzf_tags_command = 'ctags -R'

        " [Commands] --expect expression for directly executing the command
        let g:fzf_commands_expect = 'alt-enter,ctrl-x'

        let g:fzf_colors = {
                    \ 'fg':      ['fg', 'Normal'],
                    \ 'bg':      ['bg', 'Normal'],
                    \ 'hl':      ['fg', 'Comment'],
                    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                    \ 'hl+':     ['fg', 'Statement'],
                    \ 'info':    ['fg', 'PreProc'],
                    \ 'prompt':  ['fg', 'Conditional'],
                    \ 'pointer': ['fg', 'Exception'],
                    \ 'marker':  ['fg', 'Keyword'],
                    \ 'spinner': ['fg', 'Label'],
                    \ 'header':  ['fg', 'Comment']
                    \ }

        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
	" }

	" NERD Commenter {
        let g:NERDSpaceDelims = 1
        let g:NERDCompactSexyComs = 1
        let g:NERDCommentEmptyLines = 1
        let g:NERDTrimTrailingWhitespace = 1
	" }

    " Coc {
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~ '\s'
        endfunction

        inoremap <silent><expr> <TAB>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ coc#refresh()
    " }

	" Supertab {
        let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabClosePreviewOnPopupClose = 1
	" }

	" Indent Guides {
        let g:indent_guides_enable_on_vim_startup = 1
	" }

	" Vim move {
        let g:move_key_modifier = 'C'
	" }

	" Airline {
        let g:airline_theme = "kolor"
        let g:airline_mode_map = {
					\ '__' : '-',
					\ 'n'  : 'N',
					\ 'i'  : 'I',
					\ 'R'  : 'R',
					\ 'c'  : 'C',
					\ 'v'  : 'V',
					\ 'V'  : 'V',
					\ '' : 'V',
					\ 's'  : 'S',
					\ 'S'  : 'S',
					\ '' : 'S',
					\ }
        function! GetCwd()
            let currentdir = substitute(getcwd(), expand("$HOME"), "~", "g")
            return currentdir
        endfunction

        function! GetFileSize()
            let bytes = getfsize(expand("%:p"))
            if bytes <= 0
                return ""
            endif
            if bytes < 1024
                return "[" . bytes . " B]"
            else
                return "[" . (bytes / 1024) . " kB]"
            endif
        endfunction

        let g:airline_section_c = '%t %{GetFileSize()} (%{GetCwd()})'
        let g:airline_extensions = ['branch', 'hunks', 'coc']
        let g:airline_powerline_fonts = 1

        function! AccentDemo()
            let keys = ['a','b','c','d','e','f','g','h']
            for k in keys
                call airline#parts#define_text(k, k)
            endfor
            call airline#parts#define_accent('a', 'red')
            call airline#parts#define_accent('b', 'green')
            call airline#parts#define_accent('c', 'blue')
            call airline#parts#define_accent('d', 'yellow')
            call airline#parts#define_accent('e', 'orange')
            call airline#parts#define_accent('f', 'purple')
            call airline#parts#define_accent('g', 'bold')
            call airline#parts#define_accent('h', 'italic')
            let g:airline_section_a = airline#section#create(keys)
        endfunction
        autocmd VimEnter * call AccentDemo()
	" }

	" Nerdtree Git Plugin {
        let g:NERDTreeIndicatorMapCustom = {
                    \ "Modified"  : "⌘",
                    \ "Staged"    : "@",
                    \ "Untracked" : "*",
                    \ "Renamed"   : "→",
                    \ "Unmerged"  : "=",
                    \ "Deleted"   : "←",
                    \ "Dirty"     : "↓",
                    \ "Clean"     : "↑",
                    \ 'Ignored'   : '\#',
                    \ "Unknown"   : "!"
                    \ }
	" }
	
	" JSX {
        let g:jsx_ext_required = 0
	" }

	" Ctrilspace {
        if has("gui_running")
            " Settings for MacVim and Inconsolata font
            let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
        endif

        if executable("ag")
            let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
        endif
        let g:CtrlSpaceSearchTiming = 500
        nnoremap <silent><C-p> :CtrlSpace O<CR>
	" }
" }


" Key mapping {
    let mapleader = ","

	" Turn off search highlight
        nmap <leader>/ :nohl<CR>

	" Toggle wrap
        nmap <leader>tw :set invwrap<CR>:set wrap?<CR>

    " Reveal file in the tree
        nmap <leader><leader>cd :NERDTreeFind<CR>

	" Change working directory to that of current file
        nmap <leader>cd :lcd %:p:h<CR>:pwd<CR>

        nmap <leader>n :NERDTreeToggle<CR>
        nmap <leader>m :TagbarToggle<CR>

        " Split {
            nmap <leader>s :sp <C-R>=expand("%:h")."/"<CR>
            nmap <leader>v :vsp <C-R>=expand("%:h")."/"<CR>

            " Move {
                nmap <S-up> :wincmd k<CR>
                nmap <S-down> :wincmd j<CR>
                nmap <S-left> :wincmd h<CR>
                nmap <S-right> :wincmd l<CR>
            " }
        " }

        " Upper/Lower {
            nmap <leader>u mQviwU`Q
            nmap <leader>l mQviwu`Q
            nmap <leader>U mQgewvU`Q
            nmap <leader>L mQgewvu`Q
        " }

        " Mac {
            nmap <D-r> :Files<CR>
            nmap <D-e> :Buffers<CR>
            nmap <D-l> :Ag<CR>
        " }
" }
