hi! link jsonBraces Noise
hi! link jsonQuote Noise
hi! link jsonString gruvboxgreen
hi! link jsonKeyword gruvboxblue
hi! link jsonNull Constant
syn match jsonNoise /[{},:"']/ containedin=ALLBUT,jsonString,jsonKeyword
hi! link jsonNoise Noise
