import React from 'react'
import  {
    Dimensions
    PixelRatio
    BackAndroid
}  from 'react-native'

import view from './component/View'
import text from './component/Text'

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
        view,
        text
    }


export default rnweui


