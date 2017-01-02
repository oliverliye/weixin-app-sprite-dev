_ = require 'underscore'

valueExist = (value)-> _.indexOf(@values, value) > -1

checkDimension = (value)->  /\d+(((px{1,1})|(rpx{1,1}))){0,1}$/.test value

convertDimension = (value, density = 1)->
    if value.indexOf('rpx') > -1
        value = value.replace 'rpx', ''
    else if value.indexOf('px') > -1
        value = value.replace 'px', ''
        value = value / density

    parseInt value

convertRect = (value, top, right, bottom, left)->
    vs = value.split /\s+/
    vs[i] = convertDimension v for v,i in vs
    if vs.length is 1
        arr = [vs[0], vs[0], vs[0], vs[0]]

    else if vs.length is 2
        arr = [vs[0], vs[1], vs[0], vs[1]]

    else if vs.length is 3
        arr = [vs[0], vs[1], vs[2], vs[1]]

    else if vs.length is 4
        arr = [vs[0], vs[1], vs[2], vs[3]]
    "#{top}": arr[0]
    "#{right}": arr[1]
    "#{bottom}": arr[2]
    "#{left}": arr[3]

createColor = (name)->
    check: ()-> true
    convert: (value)-> "#{name}": "#{value}"

createDimension = (name)->
    check: checkDimension
    convert: (value, density) -> "#{name}": convertDimension value, density

createString = (name, values, mapping)->
    values: values
    check: valueExist
    convert: (value) -> 
        value = mapping[value] if mapping? and mapping.hasOwnProperty value
        "#{name}": "#{value}"

createNumber = (name)->
    check: ()-> true
    convert: (value) -> "#{name}": "#{value}"


prop = 
    "align-items": createString 'alignItems', ['flex-start', 'flex-end', 'center', 'stretch']

    "align-self": createString 'alignSelf', ['auto', 'flex-start', 'flex-end', 'center', 'stretch']

    "backface-visibility": createString 'backfaceVisibility', ['hidden', 'visible']

    "background-color": createColor 'backgroundColor'

    "border":
        check: ()-> true
 
        convert: (border, density)->
            vs = border.split /\s+/
            return '' if vs.length <= 0
            ret = {}
            if vs.length >= 1
                ret["borderWidth"] = "#{convertDimension vs[0], density}"
            if vs.length >= 2
                ret["borderStyle"] = "'#{vs[1]}'"
            if vs.length >= 3
                ret["borderColor"] = "'#{vs[2]}'"
            ret

    "border-bottom-color": createColor 'borderBottomColor'

    # "borderBottomLeftRadius"
    # "borderBottomRightRadius"

    "border-bottom-width": createDimension 'borderBottomWidth' 

    "border-color": createColor 'borderColor'

    "border-left-color": createColor 'borderLeftColor'

    "border-left-width": createDimension 'borderLeftWidth' 

    "border-radius": createDimension 'borderRadius' 
    
    "border-right-color": createColor 'borderRightColor'

    "border-right-width": createDimension 'borderRightWidth' 

    "border-style": createString 'borderStyle', ['soild', 'dotted', 'dashed']

    "border-top-color": createColor 'borderTopColor'

    # "borderTopLeftRadius",
    # "borderTopRightRadius",

    "border-top-width": createDimension 'borderTopWidth' 

    "border-width":
        check: checkDimension
        convert: (value)-> convertRect value, 'marginTop', 'marginRight', 'marginBottom', 'marginLeft'

    "bottom": createDimension 'bottom' 

    "color": createColor 'color'

    "flex": createNumber 'flex'

    "flex-direction": createString  'flexDirection', ['row', 'column']

    "flex-wrap": createString  'flexWrap', ['row', 'column']

    # "fontFamily",

    # "fontSize",

    "font-style": createString 'fontStyle', ['normal', 'italic']

    "font-eight": createString 'fontWeight', ['normal', 'bold', '100', '200', '300', '400', '500', '600', '700', '800', '900']

    "height": createDimension 'height' 

    "justify-content": createString 'justifyContent', ['flex-start', 'flex-end', 'center', 'space-between', 'space-around']

    "left": createDimension 'left' 

    #"letterSpacing"

    "line-height": createDimension 'lineHeight' 

    "margin": 
        check: ()-> true
        convert: (value)-> convertRect value, 'marginTop', 'marginRight', 'marginBottom', 'marginLeft'

    "margin-bottom": createDimension 'marginBottom'

    # "marginHorizontal",

    "margin-left": createDimension 'marginLeft'

    "margin-right": createDimension 'marginRight'

    "margin-top": createDimension 'marginTop'
    
    # "marginVertical",
    
    "opacity": createNumber 'opacity'

    "overflow":
        values: ['visible', 'hidden']
        check: valueExist

    "padding":
        check: ()-> true
        convert: (value)-> convertRect value, 'paddingTop', 'paddingRight', 'paddingBottom', 'paddingLeft'

    "padding-bottom": createDimension 'paddingBottom'

    # "paddingHorizontal",

    "padding-left": createDimension 'paddingLeft'

    "padding-right": createDimension 'paddingRight'

    "padding-top": createDimension 'paddingTop'

    # "paddingVertical",

    "position": createString 'position', ['absolute', 'relative']

    #"resizeMode"

    "right": createDimension 'right'

    # "rotation",
    # "scaleX",
    # "scaleY",

    "box-shadow": createColor 'shadowColor'

    # "shadowOffset",
    # "shadowOpacity",
    # "shadowRadius",

    "vertical-align": createString 'textAlignVertical', ['auto', 'top', 'bottom', 'middle'], 'middle': 'center'

    "text-align": createString 'textAlign', ['auto', 'left', 'right', 'center', 'justify']

    "text-decoration-color": createColor 'textDecorationColor'

    "text-decoration-line": createString 'textDecorationLine', ['none', 'underline', 'line-through', 'underline', 'line-through']

    "text-decoration-style": createString 'textDecorationStyle', ['solid', 'double', 'dotted', 'dashed']

    #"text-shadow": 123

    "top": createDimension 'top'

    # "tintColor",
    # "transform",
    # "transformMatrix",
    # "translateX",
    # "translateY",

    "width": createDimension 'width'

    "direction": createString 'writingDirection', ['auto', 'ltr', 'rtl']

module.exports = prop