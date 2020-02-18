# vim-fromtermcolors

Pass your terminal's color scheme through to NeoVim's syntax highlighting groups with this plugin. Not tested with vanilla Vim, but it might work out okay. No harm in trying on version 8 and up.

This has been forked from jsit's [disco.vim](https://github.com/jsit/disco.vim) to suit my own personal preferences and environments. A few of the NeoVim UI element color assignments are tweaked to improve contrast with my hand-rolled terminal color theme. From the original author:

>A full set of 1-, 8-, 16-, 88-, 256-, and GUI-color-compatible Vim colors. Aims to be bulletproof and obey terminal palette options and `background` setting if present.

>Codebase derived from jsit/vim-tomorrow-theme (which was derived from chriskempson/vim-tomorrow-theme)

## Installation

A plugin manager like [vim-plug](https://github.com/junegunn/vim-plug) is recommended. Follow your chosen plugin manager's instructions.

With vim-plug, add a new line to your plugin loading function in .vimrc/init.vim with `Plug 'jcherven/vim-fromtermcolors'`. Save and reload your config file, then run the ex command `:PlugInstall`.

Installing the plugin doesn't enable the colorscheme automatically.

## Usage

Once installed, invoke the colorscheme by the identifier `fromtermcolors`. Try it out in your current nvim session with the ex command `:colo fromtermcolors`.

To keep the colorscheme persistent,  add a new line with `colorscheme fromtermcolors` to your .vimrc or init.vim.

## Customizing and Fixing Things

It's quite likely your particular terminal color scheme will not give you satisfactory results immediately. You can try one of two things:

 - edit (or fix) how the colorscheme is mapped from your terminal's colors to nvim's highlight groups by directly editing [colors/fromtermcolors.vim](https://github.com/jcherven/vim-fromtermcolors/blob/master/colors/fromtermcolors.vim). A good idea is to fork this repository and point your plugin manager at a local clone with `Plug '~/Desktop/vim-fromtermcolors'` for instance. This way you can edit that local copy of fromtermcolors.vim and easily see your changes by sourcing .vimrc/init.vim.

- Or try out the plugin this was forked from, [disco.vim](https://github.com/jsit/disco.vim). I believe it was designed with the [base-16](https://github.com/chriskempson/base16) color themes in mind.

### Editing the Script

The cterm colors 0-15 are assigned to their canonical color names with the first eight being 'Normal' and the last eight being 'Bright'. There are also separate color designations for background, foreground, and cursor. For terminal color themes which reserve the red color indexes, alt_red and dim_alt_red are also provided.

To customize vim highlight groups, this function is provided:
```
fun! <SID>set_colors(group, fg, bg, attr)
```
 - The `group` argument refers to the name of the highlight group. See `:help highlight-groups` for reference on these.

 - The `fg` and `bg` arguments refer to the text foreground and background respectively. Read the function definition in the script to see how cterm and GUI values can be used for these arguments. See `:help highlight-args` for assistance on correctly defining these.

 - The `attr` argument refers to the text color and style treatment the group will receive. See `:help attr-list` for reference on these.

 * An empty string argument, i.e., `""` can be passed to use the default value for a color or attribute.

You may find it very helpful to run vim's builtin highlight test to see how the current highlight groups are assigned. In a  split or separate buffer, run `:source $VIMRUNTIME/syntax/hitest.vim` so that you can reference the current appearance of each highlight group as you edit.

#### Setting Vim UI Colors

An example of setting the line number column to blue with your default foreground text color:
```
call <SID>set_colors("LineNr", s:normalfg, s:normalblue, "")
```

#### Syntax Highlighting Colors

An example of setting Python conditional keywords to your cterm yellow color with italics:
```
call<SID>set_colors("pythonConditional", s:brightyellow, "", "italic")
```
#### Re-using Color Assignments

An example of re-using an existing math operator highlighting for the 'constant' keyword
```
hi link Constant Operator
```

The `hi link` command is useful for organizing your syntax highlighting in a maintainable way like so:
```
call <SID>set_colors("Type", s:brightyellow, "", "")
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type
```

## Options

- `g:fromtermcolors_nobright`: If set to `1`, don't use bright colors. Default `0`.
- `g:fromtermcolors_red_error_only`: If set to `1`, only use the red color for
  errors -- useful for terminal themes that intend to reserve this color for
  that purpose, like [Rainglow](https://rainglow.io/). Default `0`.

## License

Distributed under the same terms as Vim itself. See `:help license`.
