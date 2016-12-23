import ReactC from 'react';
##R_$wxas$_React = require "react"
import S from 'string'



R_$wxas$_loop = (data, callback)->
    ret = []
    ret.push callbac(elem, index) for elem, index in data
    ret

R_$wxas$_getViewCode = (R_$wxas$_viewData, R_$wxas$_bindData, R_$wxas$_screen, R_$wxas$_parent_size)->

    R_$wxas$_varBindArray = [];
    for R_$wxas$_key,R_$wxas$_value of R_$wxas$_bindData
      R_$wxas$_varBindArray.push("var " + R_$wxas$_key + "=R_$wxas$_bindData['" + R_$wxas$_value + "'];");

    eval(R_$wxas$_varBindArray.join(''));

    if R_$wxas$_parent_size
        R_$wxas$_parent_size_array = [R_$wxas$_parent_size]
    else
        R_$wxas$_parent_size_array = [width: R_$wxas$_screen.width, height: R_$wxas$_screen.height]

    # 计算
    R_$wxas$_compute_percent = (parentIndex, propName, value)->
        prop = R_$wxas$_parent_size_array[parentIndex]['propName']
        prop * value

    R_$wxas$_compute_density = (value)->
        value / R_$wxas$_screen.density


    R_$wxas$_parse = (R_$wxas$_viewData, R_$wxas$_parent)->

        R_$wxas$_var = 
            view: null
            children: []

        if R_$wxas$_viewData.type is 'tag'
            if R_$wxas$_viewData.name is 'import'
                # wxml文件内部的template优先级高于improt的template
                return ""
            else if R_$wxas$_viewData.name is 'include'
                return ""
            else if R_$wxas$_viewData.name is 'template'
                return ""
            else 
                for R_$wxas$_child in R_$wxas$_viewData.children
                    R_$wxas$_parent_size_array.push {width: R_$wxas$_screen.width, height: R_$wxas$_screen.height}
                    R_$wxas$_var.children.push R_$wxas$_parse R_$wxas$_child, R_$wxas$_viewData

            React.createElement RN['R_$wxas$_viewData.name'], R_$wxas$_var.children
            R_$wxas$_ret = S(R_$wxas$_viewData.template).template(render: "<RN.#{R_$wxas$_viewData.name} #{R_$wxas$_viewData.styleStr} tag>#{R_$wxas$_var.children.join('')}</RN.#{R_$wxas$_viewData.name}>").s

        else if R_$wxas$_viewData.type is 'text'
            if R_$wxas$_parent?.name is 'text'
                 R_$wxas$_ret = S(R_$wxas$_viewData.template).template(render: "#{R_$wxas$_parent.text}").s
            else
                 R_$wxas$_ret = S(R_$wxas$_viewData.template).template(render: "<RN.text>#{R_$wxas$_parent.text}</RN.text>").s

        R_$wxas$_ret

    R_$wxas$_parse R_$wxas$_viewData, null


export default {R_$wxas$_getViewCode}
