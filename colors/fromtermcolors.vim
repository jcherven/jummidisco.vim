" Vim color file vim-fromtermcolors
" Maintainer: [jcherven] <jcherven@mail.usf.edu>
" Last Change:
" URL:
" Description: A full set of 1-, 8-, 16-, 88-, 256-, and GUI-color-compatible colors.

" We need to use :h color-nr numbers for cterm, in case we are on a low-color
" terminal
let s:color_map = {
  \'NormalBlack'    : 0,
  \'NormalRed'      : 1,
  \'NormalGreen'    : 2,
  \'NormalYellow'   : 3,
  \'NormalBlue'     : 4,
  \'NormalMagenta'  : 5,
  \'NormalCyan'     : 6,
  \'NormalWhite'    : 7,
  \'BrightBlack'    : 8,
  \'BrightRed'      : 9,
  \'BrightGreen'    : 10,
  \'BrightYellow'   : 11,
  \'BrightBlue'     : 12,
  \'BrightMagenta'  : 13,
  \'BrightCyan'     : 14,
  \'BrightWhite'    : 15,
\}

" Sets the highlighting for the given group. {{{
" From github.com/jsit/vim-tomorrow-theme
" Originally by Chris Kempson and contributors
fun! <SID>set_colors(group, fg, bg, attr)

  if !empty(a:fg)
    if type(a:fg) == 1 " If a:bg is a string, look it up for cterm
      exec "hi " . a:group . " guifg=" . a:fg . " ctermfg=" . get(s:color_map, a:fg)
    else
      exec "hi " . a:group . " guifg=" . a:fg . " ctermfg=" . a:fg
    endif
  endif

  if !empty(a:bg)
    if type(a:bg) == 1 " If a:bg is a string, look it up for cterm
      exec "hi " . a:group . " guibg=" .  a:bg . " ctermbg=" . get(s:color_map, a:bg)
    else
      exec "hi " . a:group . " guibg=" . a:bg . " ctermbg=" . a:bg
    endif
  endif

  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif

endfun



hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "fromtermcolors"

" Check to see if we can do colors 8-15
if has('gui_running') || (&t_Co > 8 && (!exists('g:fromtermcolors_nobright') || g:fromtermcolors_nobright != 1))
  let s:gt_eight = 1
else
  let s:gt_eight = 0
endif

" Check to see if we can do italic
if (&t_ZH != '' && &t_ZH != '[7m')
  let s:italic = 1
else
  let s:italic = 0
endif
" }}}



" Define our colors based on the background setting
if &background == "dark" && s:gt_eight

  let s:brightbg          = 'BrightBlack'
  let s:brightfg       = 'NormalWhite'

  let s:bg           = 'NormalBlack'
  let s:fg           = 'NormalWhite'

else

  let s:fg           = 'NormalBlack'

  if s:gt_eight
    let s:bg           = 'NormalWhite'
    let s:brightbg          = 'NormalWhite'
    let s:brightfg       = 'BrightBlack'
  else
    let s:bg           = 'NONE'
    let s:brightbg          = 'NormalWhite'
    let s:brightfg       = 'NormalWhite'
  endif

endif



if &background == "dark" && s:gt_eight && (!exists('g:fromtermcolors_fg_dark') || g:fromtermcolors_fg_dark != 1)

  let s:brightred          = 'BrightRed'
  let s:brightgreen        = 'BrightGreen'
  let s:brightyellow       = 'BrightYellow'
  let s:brightblue         = 'BrightBlue'
  let s:brightmagenta      = 'BrightMagenta'
  let s:brightcyan         = 'BrightCyan'

  let s:normalred       = 'NormalRed'
  let s:normalgreen     = 'NormalGreen'
  let s:normalyellow    = 'NormalYellow'
  let s:normalblue      = 'NormalBlue'
  let s:normalmagenta   = 'NormalMagenta'
  let s:normalcyan      = 'NormalCyan'

  let s:cursoryellow = 'BrightWhite'

else

  let s:brightred          = 'NormalRed'
  let s:brightgreen        = 'NormalGreen'
  let s:brightyellow       = 'NormalYellow'
  let s:brightblue         = 'NormalBlue'
  let s:brightmagenta      = 'NormalMagenta'
  let s:brightcyan         = 'NormalCyan'

  if s:gt_eight

    let s:normalred       = 'BrightRed'
    let s:normalgreen     = 'BrightGreen'
    let s:normalyellow    = 'BrightYellow'
    let s:normalblue      = 'BrightBlue'
    let s:normalmagenta   = 'BrightMagenta'
    let s:normalcyan      = 'BrightCyan'

    let s:cursoryellow = 'BrightYellow'

  else

    let s:normalred       = s:brightred
    let s:normalgreen     = s:brightgreen
    let s:normalyellow    = s:brightyellow
    let s:normalblue      = s:brightblue
    let s:normalmagenta   = s:brightmagenta
    let s:normalcyan      = s:brightcyan

    let s:cursoryellow = s:brightyellow

  endif
endif

" Use something other than red if user has asked to use red only for errors
if exists('g:fromtermcolors_red_error_only') && g:fromtermcolors_red_error_only == 1
  let s:alt_red     = s:normalcyan
  let s:dim_alt_red = s:normalcyan
else
  let s:alt_red     = s:brightred
  let s:dim_alt_red = s:normalred
endif


if exists('g:fromtermcolors_color_map') " {{{
  for [s:key, s:val] in items(g:fromtermcolors_color_map)
    execute 'let s:' . s:key . ' = ' . s:val
  endfor
endif
" }}}


" Highlight Groups (:h highlight-groups)
" call <SID>set_colors(group, fg, bg, attr)
if s:brightfg != s:brightbg " Needs to be different from Comment
  call <SID>set_colors("ColorColumn"  , "NONE" , s:brightbg , "")
  call <SID>set_colors("CursorColumn" , "NONE" , s:brightbg , "")
  if s:gt_eight " Only turn off bold if we have enough colors
    call <SID>set_colors("CursorLine" , "" , "" , "underline")
  else
    call <SID>set_colors("CursorLine" , "" , "" , "underline")
  endif
else
  call <SID>set_colors("ColorColumn"  , "NONE" , "NONE" , "")
  call <SID>set_colors("CursorColumn" , "NONE" , "NONE" , "")
  call <SID>set_colors("CursorLine"   , ""     , ""  , "underline")
endif

call <SID>set_colors("Conceal"  , ""     , "NONE" , "")
call <SID>set_colors("Cursor"   , "NONE" , s:cursoryellow , "reverse")
call <SID>set_colors("CursorIM" , ""     , ""     , "")

call <SID>set_colors("CursorLineNr" , s:cursoryellow , s:normalblue      , "")
call <SID>set_colors("Directory"    , s:brightblue , ""         , "")
call <SID>set_colors("DiffAdd"      , s:bg   , s:normalgreen , "")
call <SID>set_colors("DiffDelete"   , s:bg   , s:normalred   , "")
call <SID>set_colors("DiffChange"   , s:bg   , s:normalcyan  , "")
call <SID>set_colors("DiffText"     , s:bg   , s:brightcyan     , "NONE")
hi link EndOfBuffer NonText
call <SID>set_colors("ErrorMsg"     , s:fg     , s:normalred      , "")

if s:brightfg != s:brightbg " Needs to be different from SignColumn
  call <SID>set_colors("VertSplit" , s:normalblue , "" , "NONE")
else
  call <SID>set_colors("VertSplit" , s:fg     , s:fg , "reverse")
endif

if s:brightfg != s:brightbg
  call <SID>set_colors("Folded"     , s:brightfg , s:brightbg    , "")
  call <SID>set_colors("FoldColumn" , s:brightfg , s:brightbg    , "")
  call <SID>set_colors("SignColumn" , s:brightfg , s:brightbg    , "")
else
  call <SID>set_colors("Folded"     , "NONE"   , s:brightfg , "")
  call <SID>set_colors("FoldColumn" , "NONE"   , s:brightfg , "")
  call <SID>set_colors("SignColumn" , "NONE"   , s:brightfg , "")
endif

call <SID>set_colors("IncSearch"  , s:normalblue , s:brightfg , "")
call <SID>set_colors("LineNr"     , s:brightbg          , ""      , "")
call <SID>set_colors("MatchParen" , s:brightbg       , s:brightfg  , "")
call <SID>set_colors("ModeMsg"    , s:brightgreen        , ""      , "")
call <SID>set_colors("MoreMsg"    , s:brightgreen        , ""      , "")
call <SID>set_colors("NonText"    , s:brightbg          , ""      , "")

if &background == "dark" && has('gui_running')
  call <SID>set_colors("Normal" , "white" , "black" , "")
else
  call <SID>set_colors("Normal" , ""      , ""      , "")
endif

call <SID>set_colors("PMenu"        , s:fg           , s:brightbg          , "")

if s:brightfg != s:brightbg
  call <SID>set_colors("PMenuSel" , s:cursoryellow , s:normalblue , "")
else
  call <SID>set_colors("PMenuSel" , s:cursoryellow , s:fg     , "")
endif

call <SID>set_colors("PMenuSbar"        , s:fg       , s:brightbg          , "")
call <SID>set_colors("PMenuThumb"       , s:fg       , s:brightbg          , "")
call <SID>set_colors("Question"         , s:brightgreen    , ""             , "")
call <SID>set_colors("Search"           , s:normalblue  , s:brightfg         , "reverse")
call <SID>set_colors("SpecialKey"       , s:brightbg      , ""             , "")
call <SID>set_colors("SpellBad"         , s:normalred   , s:fg           , "reverse")
call <SID>set_colors("SpellCap"         , ""         , s:brightred          , "reverse")
call <SID>set_colors("SpellLocal"       , ""         , s:brightred          , "reverse")
call <SID>set_colors("SpellRare"        , s:normalred   , s:fg           , "reverse")
call <SID>set_colors("StatusLine"       , s:normalyellow         , ""             , "reverse")
call <SID>set_colors("StatusLineNC"     , s:normalblue      , s:brightbg             , "")
call <SID>set_colors("StatusLineTerm"   , s:brightgreen    , "NONE"         , "reverse")
call <SID>set_colors("StatusLineTermNC" , s:normalgreen , "NONE"         , "reverse")
call <SID>set_colors("TabLine"          , s:brightbg       , s:normalblue          , "NONE")
call <SID>set_colors("TabLineFill"      , s:normalblue      , s:brightfg       , "")
call <SID>set_colors("TabLineSel"       , s:fg         , s:bg             , "NONE")
call <SID>set_colors("Title"            , "NONE"     , ""             , "")
call <SID>set_colors("Visual"           , ""         , s:normalblue          , "")
call <SID>set_colors("VisualNOS"        , s:brightbg      , ""             , "")
call <SID>set_colors("WarningMsg"       , s:brightred      , s:brightbg          , "")
call <SID>set_colors("WildMenu"         , s:brightgreen    , s:brightbg          , "")

" End Highlight Groups



" Group Names (:h group-name) {{{

if (s:italic)
  call <SID>set_colors("Comment", s:brightbg, "", "italic")
else
  call <SID>set_colors("Comment", s:brightbg, "", "")
endif

call <SID>set_colors("Constant", s:brightgreen, "", "")
hi link String    Constant
hi link Character Constant
hi link Number    Constant
hi link Boolean   Constant
hi link Float     Constant

if s:gt_eight " Only turn off bold if we have enough colors
  call <SID>set_colors("Identifier", s:brightcyan, "", "NONE")
else
  call <SID>set_colors("Identifier", s:brightcyan, "", "")
endif
hi link Function Identifier

call <SID>set_colors("Statement", s:brightmagenta, "", "")
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement

call <SID>set_colors("PreProc", s:brightblue, "", "")
hi link Include   PreProc
hi link Define    PreProc
hi link Macro     PreProc
hi link PreCondit PreProc

call <SID>set_colors("Type", s:brightyellow, "", "")
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type

call <SID>set_colors("Special", s:alt_red, "", "")
hi link SpecialChar    Special
hi link Tag            Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special

call <SID>set_colors("Underlined" , "NONE" , ""       , "underline")
call <SID>set_colors("Ignore"     , s:brightbg  , ""       , "")
call <SID>set_colors("Error"      , s:brightred  , "white"  , "reverse")
call <SID>set_colors("Todo"       , s:bg   , s:brightyellow , "")

" End Group Names



" Syntax-specific highlighting {{{
" From github.com/jsit/vim-tomorrow-theme
" Originally by Chris Kempson and contributors

" " Vim Highlighting
" exe 'hi link vimCommand Function'
"
" " C Highlighting
" call <SID>set_colors("cType"         , s:brightyellow  , "NONE" , "")
" call <SID>set_colors("cStorageClass" , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("cConditional"  , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("cRepeat"       , s:brightmagenta , "NONE" , "")
"
" " PHP Highlighting
" call <SID>set_colors("phpVarSelector"    , s:alt_red , "NONE" , "")
" call <SID>set_colors("phpKeyword"        , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("phpRepeat"         , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("phpConditional"    , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("phpStatement"      , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("phpMemberSelector" , s:fg      , "NONE" , "")
"
" " Ruby Highlighting
" call <SID>set_colors("rubySymbol"                 , s:brightgreen   , "NONE" , "")
" call <SID>set_colors("rubyConstant"               , s:brightyellow  , "NONE" , "")
" call <SID>set_colors("rubyAttribute"              , s:brightblue    , "NONE" , "")
" call <SID>set_colors("rubyInclude"                , s:brightblue    , "NONE" , "")
" call <SID>set_colors("rubyLocalVariableOrMethod"  , s:brightcyan    , "NONE" , "")
" call <SID>set_colors("rubyCurlyBlock"             , s:brightcyan    , "NONE" , "")
" call <SID>set_colors("rubyStringDelimiter"        , s:brightgreen   , "NONE" , "")
" call <SID>set_colors("rubyInterpolationDelimiter" , s:brightcyan    , "NONE" , "")
" call <SID>set_colors("rubyConditional"            , s:brightmagenta , "NONE" , "")
" call <SID>set_colors("rubyRepeat"                 , s:brightmagenta , "NONE" , "")
"
" " Python Highlighting
" exe 'hi link pythonInclude Include'
" exe 'hi link pythonStatement Statement'
" exe 'hi link pythonConditional Conditional'
" exe 'hi link pythonRepeat Repeat'
" exe 'hi link pythonException Exception'
" exe 'hi link pythonFunction Function'
"
" " Go Highlighting
" exe 'hi link goStatement Statement'
" exe 'hi link goConditional Conditional'
" exe 'hi link goRepeat Repeat'
" exe 'hi link goException Exception'
" call <SID>set_colors("goDeclaration" , s:brightblue , "NONE" , "")
" exe 'hi link goConstants Constant'
" call <SID>set_colors("goBuiltins"    , s:brightcyan , "NONE" , "")
"
" " CoffeeScript Highlighting
" exe 'hi link coffeeKeyword Keyword'
" exe 'hi link coffeeConditional Conditional'
"
" " JavaScript Highlighting
" exe 'hi link javaScriptBraces Normal'
" exe 'hi link javaScriptFunction Function'
" exe 'hi link javaScriptConditional Conditional'
" exe 'hi link javaScriptRepeat Repeat'
" exe 'hi link javaScriptNumber Number'
" exe 'hi link javaScriptMember Type'
"
" " HTML Highlighting
" hi link htmlTagName        Type
" hi link htmlTag            Type
" hi link htmlEndTag         Type
" hi link htmlArg            Statement
" hi link htmlSpecialTagName Statement
" hi link htmlScriptTag      Statement

" vim-showmarks
call <SID>set_colors("ShowMarksHLl" , s:bg , s:brightblue , "")
call <SID>set_colors("ShowMarksHLu" , s:bg , s:brightblue , "")
call <SID>set_colors("ShowMarksHLo" , s:bg , s:brightblue , "")

" End syntax-specific highlighting }}}



" Clean up
delf <SID>set_colors
unlet s:brightbg s:brightfg s:bg s:fg s:brightblue s:brightyellow s:brightred s:brightgreen s:brightcyan s:brightmagenta s:cursoryellow s:normalred s:normalgreen s:normalcyan

" ex: set noexpandtab nolist foldmethod=marker:
