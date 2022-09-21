syn match shNoise /[()]/ containedin=ALLBUT,shStrings,shSpecialString
syn match shOperators /[=+*|&\!]/ containedin=ALLBUT,shStrings
syn match shStrings /".*"/ containedin=ALLBUT,shComment
syn match shDQuote /"/ containedin=shStrings
syn match shPath :/[^/]+/: containedin=shStatement

hi! link shNoise Noise
hi! link shOperators Operator
hi! link shCommandSub cleared
hi! link shStrings String
hi! link shPath gruvboxorange
hi! link shQuote String
