S = require 'string'
_ = require 'underscore'
wxdbrn = require 'wxdatabindrn'

Config = require '../config'

isEventBind = (name)-> Config.bindEvents.indexOf(name) > -1

class Element 

    constructor: (@type, @name, attrs = {}, @text = '')->
        attrs = _.extend {}, attrs
        @children = []
        @template = "{{render}}"
        @attrs = {}
        @attrsStr = ""

        if attrs.hasOwnProperty '__styleindex'
            @styleIndex = attrs['__styleindex'] 
            delete attrs['__styleindex'] 

        if attrs.hasOwnProperty 'style'
            @style = attrs['style']
            delete attrs['style'] 

        attrsStr = []
        for key, value of attrs
            if wxdbrn.isBind value
                attrsStr.push "#{key}=#{value = wxdbrn.convert value}"
            else
                attrsStr.push """#{key}='#{value}'"""

            @attrs[key] = value

        @attrsStr = attrsStr.join ' ' if attrsStr.length > 0

    appendChild: (child)-> @children.push child

    toJsx: ()-> parse @

    toCode: ()-> (require("babel-core").transform @toJsx(), plugins: ["transform-react-jsx"]).code


parseAttr = (name, value)->
    if wxdbrn.isBind value
        "#{key}=#{value = wxdbrn.convert value}"
    else
        """#{key}='#{value}'"""
    

parse = (element, parent)->

    children = []

    style = []
    if element.hasOwnProperty 'styleIndex'
        style.push "#{Config.varPrefix}styles.style#{element.styleIndex}"
    if element.hasOwnProperty 'style'
        style.push element['style']

    style = if style.length > 0 then "style={[#{style.join()}]}" else ''

    if element.type is 'tag'
        tagName = element.name
        
        children.push parse child, element for child in element.children

        if element.name is 'template'
            ret = S(element.template).template render: children.join('')
        else
            ret = S(element.template).template(
                render: """
                    <#{Config.varPrefix}component.#{tagName} 
                        #{element.attrsStr} 
                        #{style}
                        __class={#{Config.varPrefix}class}>
                        #{children.join('')}
                    </#{Config.varPrefix}component.#{tagName}>"""
            ).s

    else if element.type is 'text'
        if parent?.name is 'text'
            ret = S(element.template).template(render: "#{parent.text}").s
        else
            ret = S(element.template).template(
                render: """
                    <#{Config.varPrefix}component.text #{element.attrsStr} #{style}>
                        #{parent.text}
                    </#{Config.varPrefix}component.text>"""
            ).s

    ret



module.exports = Element