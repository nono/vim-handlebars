" Handlebars syntax
" Language:    Handlebars
" Maintainer:  Bruno Michel <brmichel@free.fr>
" Last Change: Jun 23th, 2011
" Version:	   0.1
" URL:         https://github.com/nono/vim-handlebars


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Standard HiLink will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif


syntax match  hbsError          '}}}\?'
syntax match  hbsInsideError    '{{[{#<>=!\/]\?' containedin=@hbsInside

syntax region hbsVariable       matchgroup=hbsMarker start=/{{/ end=/}}/     containedin=@htmlHbsContainer 
syntax region hbsUnescape       matchgroup=hbsMarker start=/{{{/ end=/}}}/   containedin=@htmlHbsContainer
syntax region hbsSection        matchgroup=hbsMarker start='{{[#/]' end=/}}/ containedin=@htmlHbsContainer
syntax region hbsPartial        matchgroup=hbsMarker start=/{{[<>]/ end=/}}/
syntax region hbsMarkerSet      matchgroup=hbsMarker start=/{{=/ end=/=}}/
syntax region hbsComment        start=/{{!/ end=/}}/ contains=Todo containedin=htmlHead

" Clustering
syntax cluster hbsInside        add=hbsVariable,hbsVariableUnescape,hbsSection,hbsPartial,hbsMarkerSet
syntax cluster htmlHbsContainer add=htmlHead,htmlTitle,htmlString,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lisp_syntax_inits")
  if version < 508
    let did_lisp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HtmlHiLink hbsVariable    Number
  HtmlHiLink hbsUnescape    Number
  HtmlHiLink hbsPartial     Number
  HtmlHiLink hbsSection     Number
  HtmlHiLink hbsMarkerSet   Number

  HtmlHiLink hbsComment     Comment
  HtmlHiLink hbsMarker      Identifier
  HtmlHiLink hbsError       Error
  HtmlHiLink hbsInsideError Error

  delcommand HiLink
endif


let b:current_syntax = 'handlebars'
