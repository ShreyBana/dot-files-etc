syn match rustNoise /[:;.,]/ containedin=ALLBUT,rustString
syn match rustFuncParens /[()]/ containedin=rustFunction,rustFuncCall,rustFuncName
syn match rustArrParens /[\[\]]/ containedin=rustStatement
syn match rustBlockParens /[{}]/ containedin=ALLBUT,rustString
hi! link rustFuncCall gruvboxyellow
hi! link rustFuncName gruvboxyellow
hi! link rustNoise Noise
hi! link rustFuncParens Noise
hi! link rustArrParens Noise
hi! link rustBlockParens Noise
