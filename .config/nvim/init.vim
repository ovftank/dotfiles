"General settings
highlight Normal ctermbg=000000CC
highlight NonText ctermbg=000000CC
		filetype plugin on
		set autoindent 					"auto-indent at line break	
		set clipboard^=unnamed,unnamedplus 		"enable system clipboard sync 			
		set hidden 						"hidden E37 error
		set hlsearch 					"highlight search
		set ignorecase 					"enable case-sensitive
		set mouse=a 					"enable mouse
		set nobackup 					"disable backup
		set nowb 						"disable backup
		set noswapfile 					"disable swapfile
		set nowritebackup 				"disable write backup
		set number 						"show line number
		set shiftwidth=4 				"indent to correspond to a single tab
		set tabstop=4 					"size(space-wide) of single tab
		set termguicolors 				"set vim terminal colors
		set encoding=utf-8 				"unicode characters in the file autoload
		set wildmenu 					"allows to use J L to move on completion lists

		syntax enable 					"enable highlight syntax(java,cpp,c,...)
		syntax on     					"enable highlight syntax(java,cpp,c,...)

		" Auto reload content changed outside
		au CursorHold,CursorHoldI * checktime
		au FocusGained,BufEnter * :checktime
		autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
				\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
					\ | checktime 
				\ | endif
		autocmd FileChangedShellPost *
				\ echohl WarningMsg 
				\ | echo "File changed on disk. Buffer reloaded."
				\ | echohl None

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Key Binding
		let mapleader = "`"

		"Copy"
        vmap  <C-c> y

		"Cut"
        vnoremap  <BS>  d
		nnoremap  <BS>  D
		xnoremap  <C-x> d
        vnoremap  <C-x> d

		"Delete line"
		nnoremap <C-u> dd
		imap <C-u> <ESC><C-u>;
		
		"Delete line after cursor"
        nmap <C-p> C
        imap <C-p> <A-l><ESC>C;

    	"Exit"
		imap  <F4> <ESC>:q!<CR>
		nmap  <F4> :q!<CR>
        vmap  <F4> <ESC>:q!<CR>
		
		"go to previous word
		imap <A-I> <ESC>Ih
        nmap I B
		vmap I B

		"go to the next word
		imap <A-K> <ESC>K;
		nmap K W
		vmap K W

		"go bottom
		imap <A-D> <ESC>d;
		nmap d G
		vmap d G
		"go top
		imap <A-A> <ESC>ah
		nnoremap a gg
		vnoremap a gg
		
		"Move down	
		imap  <A-k> <ESC>k;
        nnoremap  k j
		vnoremap  k j
		
		"Move left
		imap  <A-j> <ESC>j;
        nnoremap  j h
		vnoremap  j h
		
		"Move right        
        imap  <A-l> <ESC>l;
		
		"move to beginning of line
		imap <C-j> <ESC>^h
        nmap <C-j> ^
		vmap <C-j> ^

		"move to end of line
		imap <C-l> <ESC>$;
        nmap <C-l> $
		vmap <C-l> $
        
		"Move up
		imap  <A-i> <ESC>i;
		nnoremap  i k
		vnoremap  i k
		
		"Paste"
        nmap  <C-v> p
        imap  <C-v> <ESC>p;
		vmap  <C-v> p

		
		"Redo"
        imap  	  <C-r> <ESC>:redo<CR>;
		
		"Save"
		imap  	  <C-s> <ESC>:w<CR>;
		nnoremap  <C-s> :w<CR>
		vnoremap  <C-s> <ESC>:w<CR>
		
		"Scroll down
		imap <C-q> <ESC><C-y>;
        nmap <C-q> <C-y>
		vmap <C-q> <C-y>
        


		"Scroll up
        imap      <C-e> <ESC><C-e>;

		"Select all"
		imap  <C-a> <ESC>ggVG
        nmap  <C-a> ggVG
		
		"Switch mode
        imap     <C-k> <ESC>
		vmap     <C-k> <ESC>

		"Switch mode
		nnoremap h i
		vmap  h <ESC>h
		nnoremap ; a
		vmap  h <ESC>;

		"Undo"
        nmap  <C-z> u
        imap  <C-z> <ESC>u;

		"Echo"	
		imap <left>   <ESC>:echoe "use Alt+j"<CR>;
        imap <right>  <ESC>:echoe "use Alt+l"<CR>;
        imap <up>     <ESC>:echoe "use Alt+i"<CR>;
        imap <down>   <ESC>:echoe "use Alt+k"<CR>;
        
        nmap <left>   :echoe "use j"<CR>
        nmap <right>  :echoe "use l"<CR>
        nmap <up>     :echoe "use i"<CR>
        nmap <down>   :echoe "use k"<CR>

		vmap <left>   :echoe "use j"<CR>
        vmap <right>  :echoe "use l"<CR>
        vmap <up>     :echoe "use i"<CR>
        vmap <down>   :echoe "use k"<CR>
	
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin
call plug#begin('~/.config/nvim/plugged')
	
	" Code intellisense "
        Plug 'jiangmiao/auto-pairs' 										"Parenthesis auto
        Plug 'neoclide/coc.nvim', {'branch': 'release'} 					"Language server
		Plug 'preservim/nerdcommenter' 										"Code comment
		Plug 'ervandew/supertab' 											"use tab for code completion
		
	" Code syntax highlight "
		Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git' 		"C++
		Plug 'uiiaoo/java-syntax.vim' 										"Java
		Plug 'https://github.com/udalov/kotlin-vim.git' 					"Kotlin

	" Debugging
		"Plug 'puremourning/vimspector' 										" Vimspector

	" File browser
		Plug 'preservim/nerdTree' 											" File browser  
		Plug 'Xuyuanp/nerdtree-git-plugin' 									" Git status
		Plug 'ryanoasis/vim-devicons' 										" Icon
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 						" File browser syntax highlight
		Plug 'unkiwii/vim-nerdtree-sync' 									" Sync current file

	" File search
		Plug 'junegunn/fzf', 
			\ { 'do': { -> fzf#install() } } 								" Fuzzy finder 
		Plug 'junegunn/fzf.vim'


	" Terminal
		Plug 'voldikss/vim-floaterm' 										"FloatTerminal
	
	" Theme
		Plug 'dracula/vim', { 'as': 'dracula' } 							"Dracula theme
		Plug 'itchyny/lightline.vim' 										"Light line bar
        
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin settings

"coc-vim

		autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup mygroup
  		autocmd!

  		"Setup formatexpr specified filetype(s).
  		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  		"Update signature help on jump placeholder.
  		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end
	let g:SuperTabDefaultCompletionType = "<c-n>"

	"Apply AutoFix to problem on the current line.
	nmap <leader>f  <Plug>(coc-fix-current)

	" Applying codeAction to the selected region.
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	"Applying codeAction to the current buffer.
	nmap <leader>ac <Plug>(coc-codeaction)

	" Code Lens action on the current line.
	nmap <leader>l  <Plug>(coc-codelens-action)

	" Formatting selected code.
	xmap <C-w>  <Plug>(coc-format-selected)
	nmap <C-w>  ggVG<Plug>(coc-format-selected)
	imap <C-w>  <ESC>ggVG<Plug>(coc-format-selected)

	"Make <CR> auto-select the first completion item
	imap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	"Navigate diagnostics
	nmap <silent> <A-a> <Plug>(coc-diagnostic-prev)
	nmap <silent> <A-d> <Plug>(coc-diagnostic-next)
	imap <silent> <A-a> <ESC><Plug>(coc-diagnostic-prev);
	imap <silent> <A-d> <ESC><Plug>(coc-diagnostic-next);

	"Symbol renaming.
	nmap 	 <F2>   <Plug>(coc-rename)
	imap  	 <F2> 	<ESC><Plug>(coc-rename)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Nerdcommenter
	imap <C-o> 	<ESC><leader>c<space>;
	nmap <C-o> 	<leader>c<space>
	xmap <C-o> 	<leader>c<space>
	vmap <C-o> 	<leader>c<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Disable automatic comment in newline
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FZF

	let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
	let g:fzf_preview_window = ['right:50%', 'ctrl-/']
	let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

	hi! fzf_fg ctermfg=14
	hi! fzf_fgp ctermfg=3
	hi! fzf_hl ctermfg=5
	hi! fzf_hlp ctermfg=5
	hi! fzf_info ctermfg=6
	hi! fzf_prompt ctermfg=6
	hi! fzf_spinner ctermfg=6
	hi! fzf_pointer ctermfg=3
	let g:fzf_colors = {
		\ 'fg':      ['fg', 'fzf_fg'],
		\ 'hl':      ['fg', 'fzf_hl'],
		\ 'fg+':     ['fg', 'fzf_fgp'],
		\ 'hl+':     ['fg', 'fzf_hlp'],
		\ 'info':    ['fg', 'fzf_info'],
		\ 'prompt':  ['fg', 'fzf_prompt'],
		\ 'pointer': ['fg', 'fzf_pointer'],
		\ 'spinner': ['fg', 'fzf_spinner'] }

	" :Files
	command! -bang -nargs=? -complete=dir Files
	   \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always --theme=TwoDark --style=header,numbers,snip --line-range :300 {}']}, <bang>0)
	map <F1> :Files<CR> 
	map <F13> :History<CR>

		" :Rg
	command! -bang -nargs=* Rg
	  \ call fzf#vim#grep(
		\   'rg --column --line-number --color=always --smart-case -- '.shellescape(<q-args>), 1, {'options': ['--exact', '--layout=reverse']}, <bang>0)
	map <F3> :Rg<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"File browser

	nmap <silent> <C-b> :NERDTreeToggle<CR>
	imap <silent> <C-b> <ESC>:NERDTreeToggle<CR>

	" Exit Vim if NERDTree is the only window left.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

	" Change arrow to expand/collapse tree
	let g:NERDTreeDirArrowExpandable = '▸'
	let g:NERDTreeDirArrowCollapsible = '▾'

	" Git status icon
	let g:NERDTreeGitStatusIndicatorMapCustom = {
					\ 'Modified'  :'✹',
					\ 'Staged'    :'✚',
					\ 'Untracked' :'✭',
					\ 'Renamed'   :'➜',
					\ 'Unmerged'  :'═',
					\ 'Deleted'   :'✖',
					\ 'Dirty'     :'✗',
					\ 'Ignored'   :'☒',
					\ 'Clean'     :'✔︎',
					\ 'Unknown'   :'?',
					\ }

	" Hightlight current file
	let g:nerdtree_sync_cursorline = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Nerdcommenter

	" Create default mappings
	let g:NERDCreateDefaultMappings = 1

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1

	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1

	" Align line-wise comment delimiters flush left instead of following code indentation
	let g:NERDDefaultAlign = 'left'

	" Set a language to use its alternate delimiters by default
	let g:NERDAltDelims_java = 1

	" Add your own custom formats or override the defaults
	let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1

	" Enable NERDCommenterToggle to check all selected lines is commented or not 
	let g:NERDToggleCheckAllLines = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search

	nmap <C-f> /
    imap <C-f> <ESC>/
	"Turn off highlight
    nmap <C-h> :nohl<CR>
    imap <C-h> <ESC>:nohl<CR>;


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Terminal

	let g:floaterm_position = 'topright'
	let g:floaterm_width = 0.4
	let g:floaterm_height = 0.4
	let g:floaterm_title = 'Terminal $1/$2'
	let g:floaterm_wintype = 'float'
	
	"Open Terminal
        nmap <F6> :FloatermNew --height=0.6 --width=0.4 --wintype=float --position=topright<CR>
        imap <F6> <ESC>:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=topright<CR>

	"Compile&Run Cpp
		inoremap <silent> <F8>  <ESC>:w<CR>:!g++ -o %:r %:t<CR>:FloatermNew ./%:r<CR>
		nnoremap <silent> <F8>  :w<CR>:!g++ -o %:r %:t<CR>:FloatermNew ./%:r<CR>
	

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Theme
	colorscheme dracula
