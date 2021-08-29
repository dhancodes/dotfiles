syntax on
set nocompatible
"set foldmethod=syntax                 " fold based on indent
"set foldnestmax=10                    " deepest fold is 10 levels
"set nofoldenable                      " don't fold by default
set foldlevel=1
set number
set rnu
set nowrap
set incsearch
set wildmenu
set hlsearch
set ignorecase                        " case insensitive searching
set smartcase                         " case-sensitive if expresson contains a capital letter
set autoindent                        " automatically set indent of new line
set smartindent
set splitbelow
set splitright
set laststatus=2                      " show the status line all the time
set list
set listchars=tab:\ \ ,trail:·,nbsp:· " Display extra whitespace and tabs as characters, but not by default
hi Comment ctermfg=3

set path+=**  "For a sort of fuzzy search

"For creating a tag file using ctags
command! MakeTags !ctags -R . 

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"Plugins
call plug#begin('~/.vim/plugged')
	Plug 'sirver/ultisnips'| Plug 'honza/vim-snippets'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/vim-easy-align'
call plug#end()


set conceallevel=1
let g:tex_conceal='abdmg'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<C-tab>'

augroup remember_fold
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

"executes the command on quit for texfiles.
augroup autocom
    autocmd!
     autocmd VimLeave *.tex !~/scripts/texclear.sh %
     autocmd VimLeave *.tex !~/scripts/texclear.sh %:r_handout.tex
augroup END

" autocmd FileType tex      map <Leader>c :w<CR>:!pdflatex % && bibtex %:r.aux && pdflatex % <CR><CR>
" autocmd FileType markdown map <Leader>o :!zathura %:r.pdf & <CR><CR>
" autocmd FileType markdown map <Leader>c :w<CR>:!~/scripts/makepdf.sh % <CR><CR>

autocmd FileType tex,markdown map <Leader>c :!~/scripts/makepdf.sh % <CR><CR>
autocmd FileType tex,markdown map <Leader>o :!zathura %:r.pdf & <CR><CR>
autocmd FileType markdown     map <Leader>g :!git add % && git commit -m edit && git push <CR><CR>
autocmd FileType markdown     map <Leader>b :!~/scripts/pandoc.sh % beamer <CR><CR>
autocmd FileType gap          map <Leader>c :w<CR>:!gnome-terminal -e "gap -b %"<CR><CR>
autocmd FileType gap          map <Leader>C :w<CR>:!~/scripts/makegap.sh % <CR>
autocmd FileType python       map <Leader>c :w<CR>:!python % <CR>
autocmd FileType sh           map <Leader>c :w<CR>:!./% <CR>

nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q<CR>
nnoremap <Space> @q

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

map <Leader>s :setlocal spell! spelllang=en_us <CR><CR>
map <Leader>n :setlocal nonumber! <CR><CR>
map <Leader>f :read !figlet -f 3d
map <Leader>r :%s/\s\+$//e <CR><CR>
map <Leader>d :filetype detect <CR><CR>
map <tab><Space> <Esc> /<++><Enter>"_c4l

"Alias for replace all.
noremap S :%s//gI<Left><Left><Left>
noremap Q gqq

"Calculators
inoremap <C-A> <Esc>diWi<space><C-r>=<C-r>"<CR>

map gbc yypkA =<Esc>jOscale=2<Esc>:.,+1!bc<CR>kJ

"Universal copy and paste
nnoremap Y y$
vnoremap <C-c> "+y
map <C-p> "+P

"Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

"Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" inoremap <C-j> <esc>:m .+1<CR>==i
" inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

vnoremap < <gv
vnoremap > >gv

"Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

"Now you can easily jump to the next placeholder in the file, c
"nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
"inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>
"nnoremap <c-j> /<+.\{-1,}+><cr>
match Todo /<+.\++>/

"helpers for dealing with other people's code
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
"nmap \s :set ts=4 sts=4 sw=4 et<cr>

"highlight ColorColumn ctermbg = brown
"call matchadd('ColorColumn','\%70v',100)

"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
