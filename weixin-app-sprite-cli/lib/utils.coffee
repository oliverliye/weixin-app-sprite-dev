$ = require 'cheerio'
S = require 'string'

module.exports =

    isTextNode: (dom)-> 
        $dom = $ dom
        return $dom[0].type is 'text' # or $dom[0].name is 'text'
        
    isEmptyTextNode: (dom)-> 
        $dom = $ dom
        return $dom[0].type is 'text' and S($dom.text()).isEmpty()

    isCommentNode: (dom)->
        $dom = $ dom
        return $dom[0].type is 'comment'

    isInvalidNode: (dom)->
        return @isEmptyTextNode(dom) or @isCommentNode(dom)

    isIncludeNode: (dom)->
        return dom.type is 'tag' and dom.name is 'include'

    isImportNode: (dom)->
        return dom.type is 'tag' and dom.name is 'import'

    isTemplateNode: (dom)->
        return dom.type is 'tag' and dom.name is 'template' and not S(name = $(dom).attr('is')).isEmpty()

    filterInvalidNode: (nodes) ->
        ret = []
        for node in nodes
            ret.push node unless @isEmptyTextNode(node) or @isCommentNode(node)
        ret

    filterTemplateNode: (nodes)->
        ret = []
        for node in nodes
            ret.push node if node.name isnt 'template' and not $(node).attr('is')
        ret

    chompBindLR: (str, lch = '{', rch = '}')->
        str.replace(/\{\{/g, lch).replace(/\}\}/g, rch)

    clearBindLR: (str)->
        str.replace(/\{\{/g, "").replace(/\}\}/g, "")


        


