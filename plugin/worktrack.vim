" Worktrack plugin
" Author: Marc Capell <marc.capell@gmail.com>

" ------------
" Work Journal
"  ts: Writes a timestamp and creates a task:
"      * <2015-01-12 Mon>
"      ** TASK [0%]: <pointer placed here>
" ------------

" Do not load the plugin twice
if exists('g:vim_worktrack')
    finish
endif

let g:default_filename = "worktrack.org"
let s:filename = expand('%:t')

function AddHeaderAndTask()
    set paste
    :normal localOrgTS
    :normal o** TASK [0%]:
    set nopaste
endfunction


" Only load the functionality on the configured filename.
if s:filename == g:default_filename
    " Remove the autocomment (usefull for Python) on new lines.
    autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

    nmap localOrgTS o<C-R>=strftime("* <%Y-%m-%d %a>")<ESC>
    nmap ts :call AddHeaderAndTask()<CR><S-A><SPACE>
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

let g:vim_worktrack = 1
