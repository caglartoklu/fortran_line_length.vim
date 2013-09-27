# fortran_line_length.vim

Marks the lines overflowing lines according to the extension of FORTRAN files.

Any characters occurring after this column are considered as
error, and are marked so by highlighting.

Home page:
[https://github.com/caglartoklu/fortran_line_length.vim](https://github.com/caglartoklu/fortran_line_length.vim)

Vim.org page:
[http://www.vim.org/scripts/script.php?script_id=2868](http://www.vim.org/scripts/script.php?script_id=2868)

### References

- http://gnu.huihoo.org/gcc/gcc-3.3.6/g77/Fortran-Dialect-Options.html
- http://docs.sun.com/app/docs/doc/805-4939/6j4m0vn6l?a=view (Not available anymore)

## Changelog

- 2013-09-27
  - No change in functionality, just hosted the code on Github.
  - All the development will be on Github from now on.
  - Vim.org will be updated if a major change happens.
  - The license has been changed from GPL to 2-clause FreeBSD.
- 0.0.3, 2010-04-23
  - FIX: Loosing the match ID after removing the match in another buffer.
  - Priority can be customized.
  - Group name can be customized if necessary.
  - Script will not load itself if it has been loaded before.
  - Script is now respecting the script ID to avoid clashes with others.
- 0.0.2, 2009-12-07
  - The display format for match is now read from the global variable
    `g:FORTRANMatchDisplayFormat` instead of hard coded settings.
    Now you can adapt it to your favorite colorscheme within VIMRC
    without modifiying the plugin itself.
  - The file is saved in UNIX file format instead of Windows.
- 0.0.1, 2009-11-23
  - First version.

## Installation

For [Vundle](https://github.com/gmarik/vundle) users:

    Bundle 'caglartoklu/fortran_line_length.vim'

For [Pathogen](https://github.com/tpope/vim-pathogen) users:

    cd ~/.vim/bundle
    git clone git://github.com/caglartoklu/fortran_line_length.vim

For all other users, simply drop the `fortran_line_length.vim` file to your
`plugin` directory.


## Supported Environments
- Vim (no `+Python` required)


## Usage

This plugin is run automatically. But, if you want to
use any other valid size for some reason, the commands
are available for all file types.

All commands defined by this plugin starts with `FORTRAN`.
So, you can type `:FORTRAN` and press tab to see the available commands.

Let's take a look to the following code sample:

```fortran
function ReadSettings()
    type(TAntSettings) :: ReadSettings
    type(TAntSettings) :: settings
    settings = ReadSettingsFromCsv()
    ReadSettings = settings
end function

subroutine PrintSettings(settings)
    type(TAntSettings) :: settings
    write (* , *) 'Digit Count Per Variable     : ' , settings%digitCountPerVariable
    write (* , *) 'Iteration Count              : ' , settings%iterationCount
    write (* , *) 'And Count Per Iteration      : ' , settings%andCountPerIteration
    write (* , *) 'Initial Pheromone Amount     : ' , settings%initialPheromoneAmount
    write (* , *) 'Evaporate Factor             : ' , settings%evaporateFactor
    write (* , *) 'Default Points For Worst Phi : ' , settings%defaultPointsForWorstPhi
    write (* , *) 'Default Points For Best Phi  : ' , settings%defaultPointsForBestPhi
    write (* , *) 'Ant System Usage             : ' , settings%antSystemUsage
end subroutine
```

When the plugin is activated,
the code will be highlighted as below:

![fortran_line_length2.png](https://raw.github.com/caglartoklu/fortran_line_length.vim/media/fortran_line_length2.png)

### Commands

`:FORTRANLengthAccordingToExtension`
   Sets the valid line length according to the file extension.
   This command is applied by default.

`:FORTRANStandardLength72`
   The columns occurring after the 72nd character are marked.

`:FORTRANCardImageLength80`
   The columns occurring after the 80th character are marked.

`:FORTRANExtendedLength132`
   The columns occurring after the 132nd character are marked.

`:FORTRANRemoveMatching`
   Removes the matching set by this plugin.

## Configuration

These are options that can be customized from your VIMRC:

### `g:FORTRANMatchDisplayFormat`
The format/color of the matched characters.
The default is:

    let g:FORTRANMatchDisplayFormat = 'guifg=#FF0000'

### `g:FORTRANMatchGroup`
The name of the match group. Changing this is generally unnecessary,
do it if another plugin uses the same group name.
The default is:

    let g:FORTRANMatchGroup = 'FortranLineMatch'

### `g:FORTRANMatchPriority`

The priority, Vim's default is `10`.
If some other highlighting group shadows this one, or this one
is shadowing another one, you can change it.
Higher number gives higher priority.
The default is:

    let g:FORTRANMatchPriority = 10

## License
Licensed with 2-clause license ("Simplified BSD License" or "FreeBSD License").
See the LICENSE file.


## Contact Info
You can find me on
[Google+](https://plus.google.com/108566243864924912767/posts)

Feel free to send bug reports, or ask questions.
