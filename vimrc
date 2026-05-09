set number
set relativenumber

" enable shared clipboard in nvim
" set clipboard=unnamed 

let &t_SI = "\e[6 q" 
let &t_EI = "\e[2 q"

autocmd VimEnter * silent !echo -ne "\e[2 q"

set backspace=indent,eol,start

set ttimeoutlen=10
set timeoutlen=200
