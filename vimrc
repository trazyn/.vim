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

        filetype plugin indent on                       " Turn on plugins

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

			set background=dark
			set guifont=Envy\ Code\ R\ for\ powerline:h11
			
            let g:molokai_original=1
            let g:rehash256=1

			colors molokai
		else
			colors cleanroom
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
		let NERDTreeBookmarksFile = $HOME . "/.vim/NREDTreeBookmarks"
	" }
	
	" CtrlP {
                set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store

		let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
                let g:ctrlp_working_path_mode = 0
        " }

	" Tagbar {

		let g:tagbar_autofocus = 1
		let g:tagbar_iconchars = [ "+", "-" ]
		let g:tagbar_ctags_bin = "/usr/local/Cellar/ctags/5.8/bin/ctags"
	" }
	
	" Syntastic {
        let g:syntastic_javascript_checkers = ['eslint']
        let g:syntastic_javascript_eslint_exec = 'eslint_d'
	" }
	
	" Supertab {

		let g:SuperTabDefaultCompletionType = "context"
	" }
	
	" Indent Guides {

		let g:indent_guides_start_level = 2
		let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
	" }
	
	" Emmet {
		let g:user_emmet_expandabbr_key = '<Tab>'
		let g:use_emmet_complete_tag = 1
	" }

	" Airline {

		let g:airline_powerline_fonts = 1
		let g:airline_theme = "molokai"
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
	" }
	
	let g:syntastic_c_checkers=['']
    let g:syntastic_disabled_filetypes=['html']
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

        nmap <leader><leader>o :ZoomWin<CR>

        nmap <leader><leader>u :GundoToggle<CR>

	nmap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

        nmap <leader>n :NERDTreeToggle<CR>
        nmap <leader>t :TagbarToggle<CR>

        " Mac {

		nmap <D-r> :CtrlP<CR>
		nmap <D-e> :CtrlPBuffer<CR>
        " }
" }

