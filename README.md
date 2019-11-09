# vim-thruterm-colors

This has been forked from jsit's [disco.vim](https://github.com/jsit/disco.vim) to suit my own personal preferences and environments. A few of the NeoVim UI element color assignments are tweaked to improve contrast with my hand-rolled terminal color theme.

A full set of 1-, 8-, 16-, 88-, 256-, and GUI-color-compatible Vim colors. Aims to be bulletproof and obey terminal palette options and `background` setting if present.

Codebase derived from jsit/vim-tomorrow-theme (which was derived from chriskempson/vim-tomorrow-theme)

# Options

- `g:disco_nobright`: If set to `1`, don't use bright colors. Default `0`.
- `g:disco_red_error_only`: If set to `1`, only use the red color for
  errors -- useful for terminal themes that intend to reserve this color for
  that purpose, like [Rainglow](https://rainglow.io/). Default `0`.

# License

Copyright (c) Jay Sitter. Distributed under the same terms as Vim itself. See :help license.
