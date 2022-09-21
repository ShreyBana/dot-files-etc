syn match haskellDot /\./ containedin=ALLBUT,haskellString,haskellOperators
syn keyword haskellDeriving deriving

hi! link haskellImportKeywords gruvboxredbold
hi! link haskellForeignKeyword gruvboxred
hi! link haskellKeyword gruvboxred
hi! link haskellDeclKeyword gruvboxred
hi! link haskellType gruvboxaqua
hi! link haskellOperators gruvboxblue
hi! link haskellDelimiter Noise
hi! link haskellConditional gruvboxred
hi! link haskellDot Noise
hi! link haskellNumber Number
hi! link haskellDeriving Keyword
hi! link haskellIdentifier gruvboxyellow
hi! link haskellImport Noise
