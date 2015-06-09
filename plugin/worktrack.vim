" Worktrack plugin
" Author: Marc Capell <marc.capell@gmail.com>

" ------------
" Work Journal
"  ts: Writes a timestamp and creates a task:
"      * 2015-01-12 Mon 12:09 PM
"      ** TASK [0%]: <pointer placed here>
" ------------
let g:default_filename = "worktrack.org"
let s:filename = expand('%:t')

" Only load the functionality on the configured filename.
if s:filename == g:default_filename
    " Remove the autocomment (usefull for Python) on new lines.
    autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

    nmap ts i<C-R>=strftime("\r* %Y-%m-%d %a %I:%M %p\r** TASK [0%%]: ")<CR>
endif


" -----------------------
" Append work timestamps.
" -----------------------

let s:plugindir = expand('<sfile>:p:h:h')
let s:pluginscript = s:plugindir . "/tools/append_timestamp.sh " . s:plugindir . "/data/worktrack_ts.txt"

function AppendTimestamp()
    execute "silent !. ".s:pluginscript
endfunction

" Custom save.
au BufWritePost * call AppendTimestamp()
