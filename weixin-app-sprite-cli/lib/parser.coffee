$ = require 'cheerio'
S = require 'string'

Regular = require './regular'
Utils = require './utils'
Element = require './element/element'

Template = 
    react: require './template/react'
    wxml: require './template/wxml'



bindEvents = ['bindtouchstart', 'bindtouchmove', 'bindtouchcancel', 'bindtouchend', 'bindtap', 'bindlongtap']

catchEvents = ['catchtouchstart', 'catchtouchmove', 'catchtouchcancel', 'catchtouchend', 'catchtap', 'catchlongtap']


parseAttr = (attrs)=>

    return {} unless attrs
    props = []
    styles = []
    ret = {}
    for key, value of attrs
        #console.log "#{key}:#{value}: #{bindEvents.indexOf key}"
        if bindEvents.indexOf(key) > 0 or catchEvents.indexOf(key) > 0
            ret[key] = parseEvent value
        else if key is 'class'
            styles.push "styles.#{value}"
        else if key is 'style'
            styles.push "{#{value}}"
        else
            ret[key] = parseProps value
    {props, styles}

parseEvent = (value)->
    value = Utils.clearBindLR value
    "{(event)=> this['#{value}''](event);}"

parseProps = (value)->
    if Regular.dataBind.test(value)
        "{#{Utils.chompBindLR value}}"
    else
        value

parseStyle = (value)->
    for css in style.split ';'
        continue if S(css).isEmpty()
        [props, value] = S(css).trim().s.split /\s*:\s*/


module.exports =






    text: (text, textParent = false)->

        str =  S(text).trim().s
        if Regular.dataBind.test(str)
            str = Utils.chompBindLR str
        # 如果父结点不是Text类型,包一层Text
        return unless textParent then Element.parse 'text', [], [], str else str

    node: ($node, children)->
        attrs = parseAttr($node.attr())
        Element.parse $node[0].name, attrs.props, attrs.styles, children



