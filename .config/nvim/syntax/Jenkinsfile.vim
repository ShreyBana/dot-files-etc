syn match JenkinsNoise /[(){},.:;]/ containedin=ALLBUT,groovyString,groovyDocComment,groovyLineComment
syn match JenkinsOperator /[=|&-+><^!]/ containedin=ALLBUT,groovyString,groovyDocComment,groovyLineComment
hi! link JenkinsNoise Noise
hi! link JenkinsOperator gruvboxblue

" vim: ts=2
