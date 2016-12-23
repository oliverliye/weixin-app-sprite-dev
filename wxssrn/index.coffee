S = require 'string'
_ = require('underscore');
Prop = require './prop'

module.exports = 

    parseStyle: (style)->
        #console.log style
        items = S(style).trim().s.match /[\w-]+\s*:.*/g

        #console.log items
        ret = {}
        for it in items
            [key, value] = it.split ':'
            value = S(value).trim().replace(';', '').s
            # console.log value
            #console.log Prop[key]
            # console.log Prop[key].check value
            #console.log Prop.hasOwnProperty key
            if Prop.hasOwnProperty(key) and Prop[key].check value
                prop = Prop[key]
                _.extend ret, prop.convert value, 1
            #ret[S(key).trim().camelize().s] = S(value).trim().s
        #console.log ret
        ret

