import React from 'react'
import  {
    Text
    View
    StyleSheet
}  from 'react-native'
import _ from  'underscore'

import RNWeui from '../rnweui'
import Icons from './Icons'
import Color from './Color'
import EventPropTypes from './EventPropTypes'
import PanResponder from './PanResponder'


export default React.createClass
   
    propTypes: 
        _.extend
            type: React.PropTypes.oneOf ['primary', 'default', 'warn']
            formType: React.PropTypes.oneOf ['submit', 'reset']
            size: React.PropTypes.oneOf ['default', 'mini']
            plain: React.PropTypes.bool
            disable: React.PropTypes.bool
            loading: React.PropTypes.bool
            hoverClass: React.PropTypes.string
            hoverStartTime: React.PropTypes.number
            hoverStayTime: React.PropTypes.number
        , EventPropTypes

    getDefaultProps: ()->
        hoverClass: 'none'
        hoverStartTime: 50
        hoverStayTime: 400

    getInitialState: ()->
        textColor: 'black'
        bgColor: Color.darkWhite
        borderColor: Color.lightGray

    componentWillMount: ()->
        
        config = 
            onStartShouldSetPanResponder: ()-> true

            onPanResponderGrant: ()=>
                @setState textColor: 'green', bgColor: Color.lightGray

            onPanResponderRelease: ()=>
                @setState textColor: 'black', bgColor: Color.darkWhite

        @_panPesponder = PanResponder @, config

    render: ()->

        borderWidth = 0
        borderColor = Color.lightGray
        textColor = Color.black
        opacity = 1

        if  @props.type is 'primary'
            bgColor = Color.green
            @state.textColor = Color.white
            underlayColor = Color.darkGreen
        else if @props.type is 'warn'
            bgColor = Color.red
            @state.textColor = Color.white
            underlayColor = Color.darkRed
        else 
            bgColor = Color.darkWhite
            borderWidth = RNWeui.pixel
            borderColor = Color.lightGray
            underlayColor = Color.lightGray
        
        opacity = 0.5 if @props.disable is true

        dom = <View style={styles.labelContainer}>
                {@props.children}
            </View>

        if @props.disable is true
            <View style={[styles.container, {backgroundColor: @state.bgColor, borderWidth: borderWidth, borderColor: borderColor}]}>
                {dom}
            </View>
             
        else
            <View style={[styles.container, {backgroundColor: @state.bgColor, borderWidth: borderWidth, borderColor: borderColor}]}
                {...@_panPesponder.panHandlers}>
                {dom}
            </View>

styles = StyleSheet.create

    container: 
        margin: 10
        padding: 10
        borderRadius: 5
        borderStyle : 'solid'

    labelContainer:
        alignItems: 'center'
        justifyContent: 'center'


        


