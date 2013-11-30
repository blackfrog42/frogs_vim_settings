set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'hsitz/VimOrganizer'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'klen/python-mode'
Bundle 'tpope/vim-fugitive'
Bundle 'L9'




" Sytax Plugins
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'





let g:ft_ignore_pat = '\.org'
set grepprg=grep\ -nH\ $*

syn on 						" turn syntax highlighting on
filetype plugin indent on



" -- Define smart tab completion
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>


" Auto commands for Org Mode
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()
command! OrgCapture :call org#CaptureBuffer()
command! OrgCaptureFile :call org#OpenCaptureFile()

" Powerline setup
" https://powerline.readthedocs.org/en/latest/introduction.html
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
set laststatus=2
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)



" Python-mode
" Activate rope
" Keys:
" K             Show python docs
"   Rope autocomplete
" g     Rope goto definition
" d     Rope show documentation
" f     Rope find occurrences
" b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = 'b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

"map 'run python script' to F9
"http://stackoverflow.com/questions/18948491/running-python-code-in-vim
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"-------------------------------
" a function to execute formd and return the cursor back
" to it's original position within the buffer.
 
" This script assumes formd is in your path at:
" ~/bin/formd/formd
" http://drbunsen.github.com/formd/
 
 
function! Formd(option)
    :let save_view = winsaveview()
    :let flag = a:option
    :if flag == "-r"
        :%! ~/bin/formd/formd -r
    :elseif flag == "-i"
        :%! ~/bin/formd/formd -i
    :else
        :%! ~/bin/formd/formd -f
    :endif
    :call winrestview(save_view)
endfunction
 
" formd mappings
 
nmap <leader>fr :call Formd("-r")<CR>
nmap <leader>fi :call Formd("-i")<CR>
nmap <leader>f :call Formd("-f")<CR>
