S = require 'string'
_ = require('underscore');
Prop = require './prop'

module.exports = 

    parseStyle: (style)->
        #console.log style
        #items = S(style).trim().s.match /[\w-]+\s*:.*;\s*/g
        items = S(style).trim().s.split ';'
        #console.log items
        ret = {}
        for it in items
            continue if S(it).isEmpty()
            [key, value] = it.split ':'
            key = S(key).trim().s
            value = S(value).trim().s
            #value = S(value).trim().replace(';', '').s
            # console.log value
            #console.log Prop[key]
            # console.log Prop[key].check value
            #console.log Prop.hasOwnProperty key
            if Prop.hasOwnProperty(key) and Prop[key].check value
                prop = Prop[key]
                aa = prop.convert value, 1
                _.extend ret, prop.convert value, 1

        ret

