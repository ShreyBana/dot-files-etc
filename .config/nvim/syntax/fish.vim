syn match fishNoise /[,.()\[\]]/ containedin=ALLBUT,fishString,fishComment
syn match fishOperator /[=+\-|&*]/ containedin=ALLBUT,fishString,fishComment,fishIdentifier
syn match fishNumber /[0-9]/ containedin=ALLBUT,fishString,fishComment

hi! link fishNoise Noise
hi! link fishOperator Operator
hi! link fishNumber Constant
