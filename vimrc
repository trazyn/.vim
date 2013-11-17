"-----------------------------------------------------------------------------
" My vim config
"-----------------------------------------------------------------------------

" Environment {

        set nocompatible

        call pathogen#runtime_append_all_bundles()
        call pathogen#helptags()

	set clipboard=unnamed 				" Use (*) register for copy-paste
" }

" General {

        syntax on

        set mouse=a                                     " Automatically enable mouse usage
        set mousehide                                   " Hide the mouse cursor while typing
        set laststatus=2                                " Always show the statusline
        set showcmd                                     " Show the enter command
        set cursorline                                  " Highlight current line
        set history=100                                 " Keep 100 lines of command line history
        set scrolloff=5                                 " Minimum lines to keep above and below cursor
        set nu 						" Show the line number
        set nowrap                                      " Do not wrap line
        set ruler                                       " Show line and column number
        set confirm                                     " Ask instead of just print error
        set showmatch                                   " Cursor show matching ) and }
        set autoindent                                  " Automatically indent
        set copyindent                                  " Copy the previous indentation on auto indenting
        set hidden                                      " Allow buffer switching without saving
        set nospell                                     " Disable spell checking
        set autoread                                    " Automatically read a file that has changed on disk
        set encoding=utf-8                              " Set default encoding to UTF-8

        set nobackup                                    " No *~backup file
        set noswapfile                                  " No *.swp file

        set incsearch                                   " Incremental search
        set hlsearch                                    " Highlight search
        set ignorecase                                  " Ignore case when searching
        set smartcase                                   " Ignore case if search pattern is all lowercase, case-sensitive otherwise

        set wildchar=<TAB>                              " Start wild expansion in the command line using <TAB>
        set wildmenu                                    " Wild char completion menu

        set nolist
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

        set wildignore+=*.o,*.out,*.obj,*.git,*.rbc,*.rbo,*.class,.svn,*.gem
        set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
        set wildignore+=*.swp,*~,._*
" }

" Filetypes {

        filetype plugin indent on                       " Turn on plugins

        if has ("autocmd")
                au Filetype make setlocal noexpandtab   " In makefiles, use real tabs, not tabs expanded to spaces

                au BufRead,BufNewFile {Gemfile,Rakefile,*.rake} setf ruby

                au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdb,txt} setf markdown

                au BufRead,BufNewFile *.json setf javascript
        endif
" }

" GUI {

        " Appearance {

		set t_Co=256
		set background=light

		if has ("gui_running")
			set guioptions-=T
			set guioptions-=m
			set guioptions-=L
			set guioptions-=l
			set guioptions-=R
			set guioptions-=r
			set guioptions-=b

			set lines=40
			set columns=166

			colors hemisu

		else
			colors nucolor
		endif

        " }
" }

" Plugins {

	" NERDTree {
		let NERDChristmasTree = 1
		let NERDTreeShowBookmarks = 1
		let NERDTreeDirArrows = 0
		let NERDTreeHighlightCursorline = 1
		let NERDTreeShowLineNumbers = 0
		let NERDTreeIgnore = ['\~$', '\.o$', '\.obj$', '\.out$', '\.a$', '\.swp$', '\.pyc', '\.so$', '\.pyo$', '\.DS_Store$']
		let NERDTreeBookmarksFile = "$HOME/.vim/NREDTreeBookmarks"
	" }
	
	" Tagbar {

		let g:tagbar_autofocus = 1
		let g:tagbar_iconchars = [ "+", "-" ]
	" }
	
	" CtrlP {
		
		set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store
	" }

	" Neocomplcache {

		autocmd Filetype *  				" Use syntax complete if nothing else available
				\ if &omnifunc == "" |
				\ 	setlocal omnifunc = syntaxcomplete#Complete |
				\ endif

		autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

		let OmniCpp_GlibalScopeSearch = 1
		let OmniCpp_ShowAccess = 1
		let OmniCpp_ShowPrototypeInAbbr = 1     " Show function prototype (i.e. parameters) in popup window
		let OmniCpp_MayCompleteDot = 1          " Auto complete with .
		let OmniCpp_MayCompleteArrow = 1        " Auto complete with ->
		let OmniCpp_MayCompleteScope = 1        " Auto complete with ::
		let OmniCpp_SelectFirstItem = 2         " Select first item (but don't insert)
		let OmniCpp_NamespaceSearch = 2         " Search namespaces in this and included files
		let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
	" }

	" Supertab {

		let g:SuperTabDefaultCompletionType = "context"
	" }
" }


" Key mapping {
        let mapleader = ","

	" Turn off search highlight
        nmap <leader>/ :nohl<CR>

	" Toggle wrap
        nmap <leader>tw :set invwrap<CR>:set wrap?<CR>

	" Change working directory to that of current file
        nmap <leader>cd :lcd %:p:h<CR>:pwd<CR>

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
        "
                nmap <leader>u mQviwU`Q
                nmap <leader>l mQviwu`Q
                nmap <leader>U mQgewvU`Q
                nmap <leader>L mQgewvu`Q
        " }

        nmap <leader><leader>o :ZoomWin<CR>

        nmap <leader><leader>u :GundoToggle<CR>

        nmap <F5> :NERDTreeToggle<CR>
        nmap <F6> :TagbarToggle<CR>

        " Mac {

		nmap <D-r> :CtrlP<CR>
		nmap <D-e> :BuffergatorToggle<CR>
        " }
" }

