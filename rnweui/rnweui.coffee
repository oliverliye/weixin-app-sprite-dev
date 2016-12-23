import React from 'react'
import  {
    Dimensions
    PixelRatio
    BackAndroid
}  from 'react-native'

import view from './component/View'
import text from './component/Text'
import button from './component/Button'
import pageview from './component/PageView'
import weui from './component/Weui'

rnweui =

    getScreenWidth: ()-> Dimensions.get('window').width

    getScreenHeigth: ()-> Dimensions.get('window').height

    pixel: 1/ PixelRatio.get()

    setContentWidth: (@_contentWidth)->

    setContentHeight: (@_contentHeight)->

    getContentWidth: ()-> @_contentWidth

    getContentHeight: ()-> @_contentHeight

    _duration: 200

    setDuration: (@_duration)-> 

    getDuration: ()-> @_duration

    _modal: ->

    setModal: (func)-> @_modal = func

    getModal: ()-> @_modal()

    backAndroid: (callback)->
        BackAndroid.addEventListener 'hardwareBackPress', ()=>
            if @getModal().isShow()
                @getModal().close() 
                return true
            callback()

    component: {
        weui,
        pageview,
        view,
        text,
        button
    }


export default rnweui


