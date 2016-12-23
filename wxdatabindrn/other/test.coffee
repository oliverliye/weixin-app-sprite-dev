aa = require './index'

onlyBind = /^\{\{[^\{^\}]+\}\}$/
console.log onlyBind.test "{{true}}"


bind = /\{\{.+?\}\}/g
console.log bind.test "left{{true}}right"


#console.log aa("{{true}}")