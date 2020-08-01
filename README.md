pathfinder.vim
==============

PathFinder is a tool which is using grep/ripgrep and fzf/fzy for searching
plain-text data sets for lines that match a regular expression in multiple folders simultaneously.

Features
--------
 
The main difference of PathFinder from other tools is that unlike majority
of grep-like tools, which are searching in only one folder (usually, 
currrent working dorectory), PathFinder is searching in multiple places
simultaneously. PathFinder is using option 'path' to get a list of folders
to search in. Current working directory is ignored by default. This means
that you can launch vim in any folder and safely use PathFinder. It won't
try to check all files in your home directory, or even worse, whole file
system. Another nice feature of PathFinder is that by default it will limit
checked files to having same file type as your current file. The only
requirenent is that you need to set up 'path' for you current buffer.

Commands
--------

PathFinder doesn't provide ready to use commands, but you can easily create
your own commands using provided functions.

Examples:

-  Search files using ripgrep and fzf
```
command! -bang -nargs=* PFfzf call pathfinder#fzf(<q-args>, #{file_type:<bang>1})
```
This is the most popular option.
Without a bang (!) PFfzf will use current file type with ripgep.
If you run this command with a bang, PathFinder will search in all files.

-  Search files using ripgrep and fzy
```
command! -bang -nargs=* PFpicker call pathfinder#picker(<q-args>, #{file_type:<bang>1})
```
This is the fastest option.
Use a bang to remove a file type constraint.

-  Search files using grep
```
command! -nargs=* PFgrep call pathfinder#grep(<q-args>, {})
```
This is the slowest option, but it is 100% vim-compatible and will
populate quickfix list.

Functions
---------

- pathfinder#fzf(args, opts): repgrep + zfz. Requires [fzf.vim](https://github.com/junegunn/fzf.vim).
- pathfinder#picker(args, opts): repgrep + zfy. Requires [vim-picker](https://github.com/srstevenson/vim-picker).
- pathfinder#grep(args, opts): plain grep.

Arguments:

- args is a search expression
- opts is a dictionary with options

There are currently four options:

- 'ignore_cwd': ignore current working directory. Default value is 1.
- 'file_type': use file type of the current file. Default value is 1.
- 'type-add': add current file extension and its vim file type to ripgrep's list of file types. Default value is 1.
- 'color': use color with ripgrep. Default value is 'never'.

Extra Notes
-----------

This plugin is supposed to be used with other plugins like

- [vim-apathy](https://github.com/tpope/vim-apathy)
- [vim-projectionist](https://github.com/tpope/vim-projectionist)

Credits
-------

- [vim](https://www.vim.org/)

Copyright 2020 Sergey Sikorskiy.

