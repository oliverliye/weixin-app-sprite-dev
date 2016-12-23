# CSSselect = require("css-select")

# str = "s{{a>b?a:b}}n{{b}}"
# reg = new RegExp("\{\{.+?\}\}", 'g')
# console.log reg.test str


# console.log str.match reg
# console.log str.split reg

# console.log /\d+(((px{1,1})|(rpx{1,1}))){0,1}$/.test '0 rpx a'


# console.log "1px 3px 4px".split /\s+/
# UglifyJS = require "uglify-js"

# ast = UglifyJS.parse "var b = function () {var a = 1;  console.log(a);};"
# #ast = UglifyJS.uglify.ast_mangle(ast)
# #ret = UglifyJS.uglify.gen_code ast, beautify: true

# #ret = UglifyJS.minify "var b = function () {var a = 1;  console.log(a);};", fromString: true, beautify: true
# console.log UglifyJS


# beautify = require('js-beautify').js_beautify
# console.log beautify("var b = function () {var a = 1;  console.log(a);};", { indent_size: 2 })

# Wxml = require './wxml'
# cheerio = require 'cheerio'
# fs = require 'fs'

# $ = cheerio.load (fs.readFileSync "c:/dev/weixin-app-sprite/test/testApp/pages/index/index.wxml").toString(), 
#         recognizeSelfClosing: true
#         normalizeWhitespace: true
# console.log $.root()[0].children

# $wxml = $ (readWxmlFile fileName).root()

# wx = new Wxml "c:/dev/weixin-app-sprite/test/testApp/pages/index/index.wxml"

wxdbrn = require 'wxdatabindrn'

console.log wxdbrn.isBind "{{a>1}}"