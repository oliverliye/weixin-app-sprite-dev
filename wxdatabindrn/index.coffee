onlyBind = /^\{\{[^\{^\}]+\}\}$/
mixedBind = /\{\{[^\{^\}]+\}\}/
mixedBindAll = /\{\{[^\{^\}]+\}\}/g
bindL = /\{\{/g
bindR = /\}\}/g

clearBindLR = (str)-> str.replace(bindL, "").replace(bindR, "")

chompBindLR = (str, lch = '{', rch = '}')->
        str.replace(/\{\{/g, lch).replace(/\}\}/g, rch)

isBind = (data)-> onlyBind.test(data) || mixedBind.test(data)

_convertOnly = (data)-> "{#{clearBindLR data}}"

_convertMixed = (data)->
    binds = data.match mixedBindAll
    noBinds = data.split mixedBindAll
    ret = []
    for item in noBinds
        bd = binds.shift()
        ret.push "'#{item}'#{if bd then "+(#{clearBindLR bd})"  else ''}"
    "#{ret.join '+'}"

convert = (data)->
        if onlyBind.test data
            _convertOnly data
        else if mixedBind.test data
            _convertMixed data


module.exports = {clearBindLR, chompBindLR, convert, isBind}