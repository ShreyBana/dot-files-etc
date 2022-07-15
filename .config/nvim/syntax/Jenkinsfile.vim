syn match JenkinsNoise /[(){},.:;]/ containedin=ALLBUT,jsString,groovyString
syn match JenkinsOperator /[=|&-+><^!]/ containedin=ALLBUT,jsString,groovyString
hi! link JenkinsNoise Noise
hi! link JenkinsOperator gruvboxblue
