if exists("g:loaded_pathfinder") || &cp
  finish
endif
let g:loaded_pathfinder = 1
let s:keepcpo           = &cpo
set cpo&vim

function! s:make_folder_list(opts) abort
    let l:folders = []
    let l:ignore_cwd = get(a:opts, 'ignore_cwd', 1)
    for l:cur_path in split(&path, ',')
        if l:cur_path == "."
            let l:cur_path = expand('%:p:h')
        elseif l:cur_path == '' 
            if l:ignore_cwd
                continue
            else
                let l:cur_path = getcwd()
            endif
        endif
        let l:folders += [shellescape(fnamemodify(l:cur_path, ":."))]
    endfor
    return l:folders
endfunction

function! s:make_ripgrep_cmd(args, opts) abort
    let l:color = ' --color='.get(a:opts, 'color', 'never')
    let l:file_type = ''
    let l:folders = s:make_folder_list(a:opts)
    if get(a:opts, 'file_type', 1)
        let l:file_type = ' --type '.&filetype
    endif
    let l:cmd = 'rg'.l:color.' --column --line-number --no-heading --smart-case'.l:file_type.' -- '.shellescape(a:args).' '.join(l:folders, ' ')
    " echo l:cmd
    return l:cmd
endfunction

function! s:PickerRgLineHandler(selection) abort
    let parts = split(a:selection, ':')
    return {'filename': parts[0], 'line': parts[1], 'column': parts[2]}
endfunction

function! pathfinder#fzf(args, opts) abort
    call extend(a:opts, #{color:'always'}, 'keep')
    call fzf#vim#grep(s:make_ripgrep_cmd(a:args, a:opts), 1, {}, 0)
endfunction

function! pathfinder#picker(args, opts) abort
    let l:cmd = s:make_ripgrep_cmd(a:args, a:opts)
    call picker#File(l:cmd, 'edit', {'line_handler': 's:PickerRgLineHandler'})
endfunction

function! pathfinder#grep(args, opts) abort
    exec 'grep '.shellescape(a:args).' -R '.join(s:make_folder_list(a:opts), ' ')
endfunction

let &cpo= s:keepcpo
unlet s:keepcpo

