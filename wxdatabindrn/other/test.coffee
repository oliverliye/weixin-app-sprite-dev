aa = require './index'

onlyBind = /^\{\{[^\{^\}]+\}\}$/
console.log onlyBind.test "{{true}}"


bind = /\{\{.+?\}\}/g
console.log bind.test "left{{true}}right"


bind = /\{\{[^\{^\}]+\}\}/g

console.log bind.test "width:200;height:{{200}};background-color:red;"

#console.log aa("{{true}}")