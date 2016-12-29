$ = require 'cheerio'
S = require 'string'
_ = require 'underscore'
fs = require 'fs'
wxdbrn = require 'wxdatabindrn'

Utils = require './utils'
Element = require './element'
Template = require './template'

class Wxml

    constructor: (@basePath, @$root)->

    convertNode: ($dom)->

        return null if Utils.isInvalidNode($dom)

        # TODO: 引处暂时移除key标签
        $dom.removeAttr 'wx:key'

        isTextNode = Utils.isTextNode $dom
        hasChildren = $dom[0].children?.length > 0 

        if $dom[0].type is 'root'
            element = new Element 'tag', 'view', {}

        else if $dom[0].name is 'template'
            element = new Element 'tag', 'template', {}
            element.template = Template.createImportTemplate $dom.attr('data')

        else 
            element = new Element $dom[0].type, $dom[0].name, $dom.attr(), wxdbrn.chompBindLR $dom.text()

        if hasChildren
            nodes = Utils.filterInvalidNode $dom[0].children
            if nodes.length > 0
                ifs = []
                for child in $dom[0].children

                    $child = $ child
                    $child.removeAttr 'wx:key'

                    continue if Utils.isInvalidNode($child)

                    template = null
                    templateFor = null

                    # 转换带循环属性的标签
                    unless S(wxfor = $child.attr 'wx:for').isEmpty()

                        item = if S($child.attr 'wx:for-item').isEmpty() then 'item' else $child.attr 'wx:for-item'
                        index = if S($child.attr 'wx:for-index').isEmpty() then 'index' else $child.attr 'wx:for-index'
                        templateFor = Template.createLoop(wxdbrn.clearBindLR(wxfor), item, index);
                        
                        $child.removeAttr 'wx:for'
                        $child.removeAttr 'wx:for-item'
                        $child.removeAttr 'wx:for-index'

                    # 转换带条件属性的标签
                    if _.isString hidden = $child.attr('hidden') #typeof (hidden = $child.attr('hidden')) is 'string'
                        if wxdbrn.isBind hidden
                            hidden = wxdbrn.clearBindLR hidden
                        else
                            hidden = true

                        $child.removeAttr 'hidden'
                        template = "{ #{hidden} ? {{render}} : null }"

                    else unless S(wxif = $child.attr('wx:if')).isEmpty()
                        if wxdbrn.isBind wxif
                            wxif = wxdbrn.clearBindLR wxif
                        else 
                            wxif = true
                        ifs.push wxif
                        template = "{ #{wxif} ? ({{render}}) : null }"
                        $child.removeAttr 'wx:if'

                    else unless S(wxelif = $child.attr('wx:elif')).isEmpty()
                        if wxdbrn.isBind wxelif
                            wxelif = wxdbrn.clearBindLR wxelif
                        else
                            wxelif = true

                        condition = ""
                        condition += "!(#{wxif}) && " for wxif in ifs

                        template = "{ #{condition} #{wxelif} ? {{render}} : null }"
                        ifs.push wxelif
                        $child.removeAttr 'wx:elif'

                    else if $child.attr('wx:else') is ''
                        condition = ""
                        condition += "!(#{wxif}) && " for wxif in ifs

                        template = "{ #{condition} true ? {{render}} : null }"

                        $child.removeAttr 'wx:else'

                    item = @convertNode $(child)

                    if not template and templateFor
                        template = "{#{templateFor}}"
                    else if template and templateFor
                        template = S(template).template(render: templateFor).s

                    item.template = template if template
                    element.appendChild item 
        element

    parse:  ()-> @convertNode @$root


class WxmlLoader

    constructor: (@path, pageName)->
        @templates = {}
        @imports = {}
        @importsSrc = []
        @importsArray = []

        @$wxml = $.load (fs.readFileSync "#{@path}/#{pageName}").toString(), 
            recognizeSelfClosing: true
            normalizeWhitespace: true

        for template in @$wxml.root().find 'template[name]'
            $template = $ template

            if $template[0].children?.length > 0
                for child in $template[0].children
                    $(child).insertBefore $template
            @templates[$template.attr('name')] = $template
            $template.remove()

        #console.log _.allKeys @templates

        for importTemplate in @$wxml.root().find 'import[src]'
            $importTemplate = $ importTemplate
            src = $importTemplate.attr 'src'
            @imports[src] = (readWxmlFile @path, src).templates
            @importsArray.push @imports[src]

        #console.log @$wxml.html()

    load: ()-> 
        @_pretreatment @path, @$wxml.root()
        {$wxml: @$wxml.root(), @templates}
        

    ###
        预处理wxml
        1.将未包含在标签里的文字结点，外面包一层text标签
        2.将include的wxml替换为当前结点
    ###
    _pretreatment: (path, $node)->

        return unless node = $node[0]

        # 将未包含在标签里的文字结点，外面包一层text标签
        if node.type is 'text' and not ($node.parent()[0]?.name is 'text') and not Utils.isEmptyTextNode node
            $node.wrap $('<text>')

        # include标签
        else if Utils.isIncludeNode node

            # 将include的wxml替换为当前结点
            $node.replaceWith(readWxmlFile(path, $node.attr 'src').$wxml.children()).remove()
            return

        # import标签
        else if Utils.isImportNode node

            @importsSrc.push $node.attr 'src'
            $node.remove()
            return

        else if Utils.isTemplateNode node
            
            name = $node.attr 'is'
            data = $node.attr 'data'
            data = '' unless data
            
            if _.has @templates, name
                $node.replaceWith @templates[name].clone().attr name: name, is: $node.attr('is'), data: data

            else if _.size(@importsSrc) > 0
                src = _.last @importsSrc    
                if _.has(@imports, src) and _.has(@imports[src], name)
                    $template = @imports[src][name]
                    $node.replaceWith $template.clone().attr name: src, is: $node.attr('is'), data: data

            return
        else if node.children?.length > 0

            len = @importsSrc.length
            @_pretreatment path, $(child) for child in node.children
            @importsSrc = @importsSrc[0...len-1] if @importsSrc.length > len

        return

readWxmlFile = (path, pageName)->
    wp = new WxmlLoader path, pageName
    wp.load()


module.exports = (path, pageName, wxss = null)->

    {$wxml, templates} = readWxmlFile path, pageName + '.wxml'

    #console.log $wxml.html()

    wxss?.setToWxml $wxml
  
    element = (new Wxml path, $wxml).parse()

    #console.log element.toJsx()

    pageProvider = Template.createPageProvider element.toCode(), pageName
    fs.writeFileSync "#{path}/RN_#{pageName}_provider.js", pageProvider
    fs.writeFileSync "#{path}/RN_#{pageName}_styles.js", Template.createStyle if wxss then wxss.toStyleCode() else ''
    fs.writeFileSync "#{path}/RN_#{pageName}_class.js", Template.createStyle if wxss then wxss.toClassCode() else ''









 
