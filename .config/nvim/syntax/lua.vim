syn match luaNoise /[{},.:;\[\]()]/ containedin=ALLBUT,luaString,luaComment
syn match luaOperator /[=<>|&+-]/ containedin=ALLBUT,luaString,luaComment
syn keyword luaEnd end containedin=ALLBUT,luaString,luaComment
syn keyword luaIn in containedin=ALLBUT,luaString,luaComment

hi! link luaNoise Noise
hi! link luaOperator Operator
hi! link luaEnd Keyword
hi! link luaTable Noise
