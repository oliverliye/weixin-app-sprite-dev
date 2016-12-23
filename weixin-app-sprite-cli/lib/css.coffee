S = require 'string'
#cssRegex = /(\.\w+\s*|\w+\s*|#\w+\s*)+\{(\s*\w+\s*:\s*\w\s*;\s*)+\}/g


cssRegex = /.+\{(\s*\w+\s*:\s*\w\s*;\s*)+\}/g


cssRegex = /[^\{^\}]+\{[^\{^\}]+\}/g

classRegex = /\.\w+\s*\{(\s*\w+\s*:\s*\w\s*;\s*)+\}/g

tagRegex = /\w+\s*\{(\s*\w+\s*:\s*\w\s*;\s*)+\}/g

idRegex = /#\w+\s*\{(\s*\w+\s*:\s*\w\s*;\s*)+\}/g

idRegex = /#\w+\s*\{(\s*\w+\s*:\s*\w\s*;\s*)+\}/g

importCmd = /@import\s*"\w+"/g

css  = """
.ccc {
    sdfsdf
    a: 1
    b:2;
}

.ccc , aa{
    a: 1;
    b:2;
}

.ccc aa, aa {
    a: 1;
    b:2;
}



text {
  text-align: ddd; 
  color: green;
}

#ccc #aaa {
    a: 1;
    b:2;
}

"""

console.log css.match cssRegex

console.log "text { a:1\n b: 2}".split /\{|\}/

console.log "\n\ntext \n\n .cc aa \n\n".match /[^\s]+/g


console.log "\n\ntext-align: 100px\n\n color: green;\n\n".match /[\w-]+\s*:\s*[\w\d-]+/g


style = "width: 30px; height:650px; "

for css in style.split ';'
    continue if S(css).isEmpty()
    [props, value] = S(css).trim().s.split /\s*:\s*/

    console.log props
    console.log value