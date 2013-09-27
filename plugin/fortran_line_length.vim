" -*- vim -*-
" FILE: fortran_line_length.vim
" PLUGINTYPE: plugin
" DESCRIPTION: Marks the lines overflowing lines according to the extension of FORTRAN source files.
" HOMEPAGE: https://github.com/caglartoklu/fortran_line_length.vim
" LICENSE: https://github.com/caglartoklu/fortran_line_length.vim/blob/master/LICENSE
" AUTHOR: caglartoklu

if exists("g:loaded_fortran_line_length") || &cp
    " If it already loaded, do not load it again.
    finish
endif


let g:loaded_fortran_line_length = 1


" Define the commands.
command! -nargs=0 FORTRANLengthAccordingToExtension :
            \ call s:SetLineLenghtAccordingToFileExtension()
command! -nargs=0 FORTRANStandardLength72          :
            \ call s:SetLineLengthForFortranStandard()
command! -nargs=0 FORTRANCardImageLength80         :
            \ call s:SetLineLengthForFortranCardImage()
command! -nargs=0 FORTRANExtendedLength132         :
            \ call s:SetLineLengthForFortranExtended()
command! -nargs=0 FORTRANRemoveMatching            :
            \ call s:RemoveFortranMatching()


function! s:SetFortranLineLengthSettings()
    " Sets the default options for the plugin.

    " Set the match display format.
    if !exists('g:FORTRANMatchDisplayFormat')
        let g:FORTRANMatchDisplayFormat = 'guifg=#FF0000'
    endif

    " Set the group name for match.
    " It is recommended not to change this.
    if !exists('g:FORTRANMatchGroup')
        let g:FORTRANMatchGroup = 'FortranLineMatch'
    endif

    " Define the highlighting only once.
    exec 'hi ' . g:FORTRANMatchGroup . ' ' . g:FORTRANMatchDisplayFormat

    " Set the priority for matching.
    " Higher values gives more priority.
    " Default value is 10. See
    " :help matchadd
    if !exists('g:FORTRANMatchPriority')
        let g:FORTRANMatchPriority = 10
    endif
endfunction


function! s:IsKnownFileExtension()
    " Returns 1 if the file extension is one of the defined
    " ones, 0 otherwise.
    let current_file_extension = expand('%:e')
    let known_extensions = split("f f77 for f90 f95 f03 f08")
    let known = count(known_extensions, current_file_extension)
    return known
endfunction


function! s:SetLineLenghtAccordingToFileExtension()
    " Checks the file extension, and it sets the valid
    " line size according to that.
    " This function is called by default.
    let current_file_extension = expand('%:e')

    if s:IsKnownFileExtension()
        " Set the matching if and only if the file extension is known,
        " and one of the predefined FORTRAN extensions.
        if current_file_extension == 'f'
            call s:SetLineLengthForFortranStandard()
        elseif current_file_extension == 'f77'
            call s:SetLineLengthForFortranStandard()
        elseif current_file_extension == 'for'
            call s:SetLineLengthForFortranStandard()
        elseif current_file_extension == 'f90'
            call s:SetLineLengthForFortranExtended()
        elseif current_file_extension == 'f95'
            call s:SetLineLengthForFortranExtended()
        elseif current_file_extension == 'f03'
            call s:SetLineLengthForFortranExtended()
        elseif current_file_extension == 'f08'
            call s:SetLineLengthForFortranExtended()
        endif
    else
        " Do not try to apply the match highlighting from an unknown
        " file extension.
        " Remove all the matches applied by this plugin.
        call s:RemoveFortranMatching()
    endif
endfunction


function! s:SetLineLengthForFortranStandard()
    " Sets the standard fixed format, 72 characters.
    call s:RemoveFortranMatching()
    let g:fortranMatched = matchadd(g:FORTRANMatchGroup, '\%>72v.\+', g:FORTRANMatchPriority)
endfunction


function! s:SetLineLengthForFortranCardImage()
    " Sets the card image format, 80 characters.
    call s:RemoveFortranMatching()
    let g:fortranMatched = matchadd(g:FORTRANMatchGroup, '\%>80v.\+', g:FORTRANMatchPriority)
endfunction


function! s:SetLineLengthForFortranExtended()
    " Sets the modern, extended format, 132 characters.
    call s:RemoveFortranMatching()
    let g:fortranMatched = matchadd(g:FORTRANMatchGroup, '\%>132v.\+', g:FORTRANMatchPriority)
    Decho "extended"
endfunction


function! s:RemoveFortranMatching()
    " Removes all the matching set by this plugin.
    "
    " First, get the list of all matches.
    " [{'group': 'MyGroup1', 'pattern': 'some1',
    " 'priority': 10, 'id': 1}, {'group': 'MyGroup2',
    " 'pattern': 'some2', 'priority': 10, 'id': 2}]
    let ms = getmatches()
    " Then, traverse the list, and remove all the matches with the group
    " g:FORTRANMatchGroup.
    for m1 in ms
        let mgrp = m1['group']
        let mptn = m1['pattern']
        let mpri = m1['priority']
        let mid = m1['id']
        if mgrp == g:FORTRANMatchGroup
            call matchdelete(mid)
            " let x = input(mid)
            " let g:fortranLastMatchId = mid
        endif
    endfor
endfunction

" Define the settings once.
call s:SetFortranLineLengthSettings()

" Set the valid line length by default.
" It also removes the matching for other file types.
au BufEnter * call s:SetLineLenghtAccordingToFileExtension()
