S = require 'string'
_ = require 'underscore'
$ = require 'cheerio'
fs = require 'fs'
path = require 'path'
wxssrn = require 'wxssrn'
wxdbrn = require 'wxdatabindrn'

Config = require '../config'

parseClass = (data) ->

    # 过滤注释
    #continue if /\/\*|\/\//.test item 
    selectors = []

    for item in data.match /[^\{^\}]+\{[^\{^\}]+\}/g
        [name, style] = S(item).trim().s.split /\{|\}/
        
        # 拆分群组选择器
        for selector in name.split(',')
            selector = S(selector).trim().s
            unless S(selector).isEmpty()
                selector = selector.match(/[^\s]+/g).join ' '
                selectors.push 
                    selector: selector
                    style: wxssrn.parseStyle style
                    priority: getPriority selector
    selectors


getPriority = (selector)->
    priority = 0
    for item in selector.match /\.\w+[\w\-]+|#\w+[\w\-]+|\w+[\w\-]+/g
        # id selector
        if (/#\w+[\w\-]+/).test item
            priority += 10000
        # class selector
        else if (/\.\w+[\w\-]+/).test item
            priority += 100
        # tag selector
        else if (/\w+[\w\-]+/).test item
            priority += 1
    priority

setImport = (basePath, data)->

    improts = data.match /@import\s+("|')(.+?)("|')\s*;/g

    return data unless improts

    for item in improts
        pathName = basePath + '/' + /("|')(.+?)("|')/.exec(item)[2]
        subData = setImport path.dirname(pathName), (fs.readFileSync pathName).toString()
        data = S(data).replaceAll(item, subData).s
    data


class Wxss

    constructor: (filePath)->

        data = setImport path.dirname(filePath), (fs.readFileSync filePath).toString()

        console.log data
        @selectors = []
        @styles = {}

        # 过滤掉注释
        data = data.replace /\/\*[\s\S]*\*\//g, ''
        
        @selectors = parseClass data

        @selectors.sort (v1, v2)->
            return -1 if v1.priority < v2.priority
            return 1 if v1.priority > v2.priority
            return 0


    setToWxml: (wxml)->
        @styles = {}
        $wxml = $ wxml

        selectorMap = {}
        for item in @selectors

            selectorMap[item.selector] = item.style

            $(item.selector, $wxml).each (index, elem)->

                $elem = $ elem
                if style = $elem.data "style"
                    style = _.extend style, item.style
                else
                    style = item.style

                $elem.data "style", style

        styleIndex = 0

        $('*', $wxml).each (index, elem) =>

            $elem = $ elem
            data = $elem.data "style"
            cls = $elem.attr "class"
            style = $elem.attr 'style'

            return unless not S(data).isEmpty() or not S(cls).isEmpty() or not S(style).isEmpty()

            styleData = {}
            
            styleData = _.extend styleData, data if data

            # class attr
            if cls
                for item in cls.split ' '
                    item = ".#{item}"
                    styleData = _.extend styleData, selectorMap[item] if selectorMap.hasOwnProperty item 
                $elem.removeAttr 'class'

            # style
            if style
                if wxdbrn.isBind style
                    $elem.attr 'style', style
                else
                    styleData = _.extend styleData, wxssrn.parseStyle style 
                    $elem.removeAttr 'style'

            if _.allKeys(styleData).length > 0
                $elem.attr '__styleindex', styleIndex
                @styles["style#{styleIndex}"] = styleData
                styleIndex++

    toStyleCode: ()->

        styles  = []
        for name, content of @styles
            props = []
            for pn, pv of content 
                if _.isString pv
                    props.push "#{pn}: '#{pv}'"  
                else
                    props.push "#{pn}: #{pv}"  

            styles.push """#{name}:{#{props.join ","}}"""
        
        if styles.length <= 0
            return null
        else
            styles.join ","

    toClassCode: ()->

        styles  = []
        for item in @selectors
            continue unless item.priority is 100
            props = []
            for name, content of item.style
                if _.isString content
                    props.push "#{name}: '#{content}'"
                else
                    props.push "#{name}: #{content}"
                
            styles.push """#{S(item.selector).camelize().replaceAll(".", "").s}:{#{props.join ","}}"""

        if styles.length <= 0
            return null
        else
            styles.join ","


module.exports = Wxss



