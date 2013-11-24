
inoremap ;; <Esc> 

let g:agenda_files = ['~/Dropbox/todo.org']
let g:agenda_files += split(glob("~/Dropbox/notes/*.org"),"\n")

let g:org_agenda_select_dirs=["~/Dropbox/notes","~/Dropbox"]
let g:agenda_dirs=["~/Dropbox/notes"]


"let g:agenda_files = split(glob("~/Dropbox/*.org"),"\n")
"let g:agenda_files += split(glob("~/Dropbox/notes/*.org"),"\n")
"let g:agenda_files += split(glob("."),"\n")
"let g:org_agenda_select_dirs=g:agenda_files
echom "ORG MODE ACTIVATED! There are " . len(g:agenda_files) . " files in agenda buffer."

cd ~/Dropbox/notes
