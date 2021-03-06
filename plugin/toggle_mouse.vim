"
" Toggle mouse plugin for quickly toggling mouse between Vim and terminal
" Maintainer:   Vincent Driessen <vincent@datafox.nl>
" Version:      Vim 7 (may work with lower Vim versions, but not tested)
" URL:          http://github.com/nvie/vim-togglemouse
"
" Only do this when not done yet for this buffer
if exists("b:loaded_toggle_mouse_plugin")
    finish
endif
let b:loaded_toggle_mouse_plugin = 1

fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif
    if !exists("s:old_number")
        let s:old_number = 1
    endif
    if !exists("s:old_relativenumber")
        let s:old_relativenumber = 1
    endif
    if exists("g:ale_enabled")
        ALEToggle
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        let &number = s:old_number
        let &relativenumber = s:old_relativenumber
        if g:indentLine_loaded
            IndentLinesEnable
        endif
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let s:old_number = &number
        let s:old_relativenumber = &relativenumber
        let &mouse = ""
        set nonumber
        set norelativenumber
        if g:indentLine_loaded
            IndentLinesDisable
        endif
        echo "Mouse is for terminal"
    endif
endfunction

" Add mappings, unless the user didn't want this.
" The default mapping is registered under to <F12> by default, unless the user
" remapped it already (or a mapping exists already for <F12>)
if !exists("no_plugin_maps") && !exists("no_toggle_mouse_maps")
    if !hasmapto('<SID>ToggleMouse()')
        noremap <F12> :call <SID>ToggleMouse()<CR>
        inoremap <F12> <Esc>:call <SID>ToggleMouse()<CR>a
    endif
endif
