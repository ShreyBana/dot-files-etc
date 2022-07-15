syn match haskellDot /\./ containedin=ALLBUT,haskellString,haskellOperators
syn keyword haskellDeriving deriving

hi! link haskellImportKeywords gruvboxred
hi! link haskellForeignKeyword gruvboxred
hi! link haskellKeyword gruvboxred
hi! link haskellDeclKeyword gruvboxred
hi! link haskellType gruvboxyellow
hi! link haskellOperators gruvboxblue
hi! link haskellDelimiter Noise
hi! link haskellConditional gruvboxred
hi! link haskellDot Noise
hi! link haskellNumber Number
hi! link haskellDeriving Keyword
