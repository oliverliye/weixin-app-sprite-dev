import React from 'react'
import  {
    Text
    View
    StyleSheet
    TouchableHighlight
    PanResponder
}  from 'react-native'

import RNWeui from '../rnweui'
import Icons from './Icons'
import Color from './Color'


export default React.createClass
   
    propTypes: 
        type: React.PropTypes.oneOf ['primary', 'default', 'warn']
        formType: React.PropTypes.oneOf ['submit', 'reset']
        size: React.PropTypes.oneOf ['default', 'mini']
        plain: React.PropTypes.bool
        disable: React.PropTypes.bool
        loading: React.PropTypes.bool
        label: React.PropTypes.string
        onPress: React.PropTypes.func

    componentWillMount: ()->
        @_panResponder = PanResponder.create
            onStartShouldSetPanResponder: (evt, gestureState) => true
            onStartShouldSetPanResponderCapture: (evt, gestureState) => false
            onMoveShouldSetPanResponder: (evt, gestureState) => true
            onMoveShouldSetPanResponderCapture: (evt, gestureState) => false
            onPanResponderTerminationRequest: (evt, gestureState) => true

            onPanResponderGrant: (e, gestureState) => 
                @state.setOnceOffset = true
                if @state.scrollState isnt 'none'
                    @state.top.stopAnimation()

            onPanResponderMove: (e, gestureState)=>

                if @state.setOnceOffset is true
                    @state.top.setOffset  @state.top._value
                    @state.setOnceOffset = false

                Animated.event([null, dy:@state.top])(e, gestureState)

            onPanResponderRelease: (e, gestureState) => 
                @state.top.flattenOffset()

                if @state.top._value > 0 or @state.scrollState is 'toTop'
                    @_toTop()
                else if @state.top._value < 0 and @state.viewHeight <= 500
                    @_toTop()
                else if @state.viewHeight > 500 and Math.abs(@state.top._value) > Math.abs (500 - @state.viewHeight)
                    @_toBottom()
                else
                    @_decaying gestureState.vy

    render: ()->

        borderWidth = 0
        borderColor = Color.lightGray
        textColor = Color.black
        opacity = 1

        if  @props.type is 'primary'
            bgColor = Color.green
            textColor = Color.white
            underlayColor = Color.darkGreen
        else if @props.type is 'warn'
            bgColor = Color.red
            textColor = Color.white
            underlayColor = Color.darkRed
        else 
            bgColor = Color.darkWhite
            borderWidth = RNWeui.pixel
            borderColor = Color.lightGray
            underlayColor = Color.lightGray
        
        opacity = 0.5 if @props.disable is true

        dom = <View style={styles.labelContainer}>
                    <Text style={{color: textColor, opacity: opacity}}>{@props.label}</Text>
                </View>

        if @props.disable is true
            <View style={[styles.container, {backgroundColor: bgColor, borderWidth: borderWidth, borderColor: borderColor}]}>
                {dom}
            </View>
             
        else
            <TouchableHighlight style={[styles.container, {backgroundColor: bgColor, borderWidth: borderWidth, borderColor: borderColor}]} 
                underlayColor={underlayColor} onPress={@props.onPress}>
                {dom}
            </TouchableHighlight>

styles = StyleSheet.create

    container: 
        margin: 10
        padding: 10
        borderRadius: 5
        borderStyle : 'solid'

    labelContainer:
        alignItems: 'center'
        justifyContent: 'center'


        


