S = require 'string'
_ = require 'underscore'
wxdbrn = require 'wxdatabindrn'

Config = require '../config'

isEvent = (name)-> Config.bindEvents.indexOf(name) > -1

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
            if isEvent key
                if wxdbrn.isBind value
                    value = wxdbrn.convert value
                else
                    value = "'#{value}'"

                attrsStr.push """ #{key}={(function(){return #{Config.varPrefix}page[#{value}]})()} """

            else
                key = S(key).camelize().s
                if wxdbrn.isBind value
                    attrsStr.push "#{key}=#{value = wxdbrn.convert value}"
                else
                    attrsStr.push """ #{key}="#{value}" """

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
        if wxdbrn.isBind element.style
            style.push "#{Config.varPrefix}wxssrn.parseStyle(#{wxdbrn.convert(element.style)})"
        else
            style.push "#{Config.varPrefix}wxssrn.parseStyle('#{element.style}')"

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
                        wxasClass={#{Config.varPrefix}class}>
                        #{children.join('')}
                    </#{Config.varPrefix}component.#{tagName}>"""
            ).s

    else if element.type is 'text'
        if parent?.name is 'text'
            ret = S(element.template).template(render: "#{parent.text}").s
        else
            ret = S(element.template).template(
                render: """
                    <#{Config.varPrefix}component.text 
                        #{element.attrsStr} 
                        #{style}
                        wxasClass={#{Config.varPrefix}class}>
                        #{parent.text}
                    </#{Config.varPrefix}component.text>"""
            ).s

    ret



module.exports = Element