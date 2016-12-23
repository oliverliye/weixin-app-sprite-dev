import React from 'react'
import  {
    Text
    View
    Animated
    Easing
    StyleSheet
    TouchableWithoutFeedback
}  from 'react-native'

import RNWeui from '../rnweui'
import AnimateUtils from '../utils/AnimateUtils'
import Icons from './Icons'
import Color from './Color'

export default React.createClass

    propTypes:
        title: React.PropTypes.string
        checked: React.PropTypes.bool
        disabled: React.PropTypes.bool
        onChange: React.PropTypes.func

    getDefaultProps: ()->
        checked: false
        title: ''
        onChange: ()->
   
    getInitialState: ()-> 

        data = @_getAnimateData @props.checked

        checked: @props.checked
        marginLeft: AnimateUtils.value data.value
        wh: AnimateUtils.valueXY x: data.whx, y: data.why
        lt: AnimateUtils.valueXY x: data.ltx, y: data.lty

    _getAnimateData: (checked)->
        if checked
            value: 19
            whx: 0
            why: 0
            ltx: 25
            lty: 15
        else
            value: 0
            whx: 51
            why: 31
            ltx: 0
            lty: 0

    _onPress: ()->

        return if @props.disabled

        checked = !@state.checked
        
        @setState checked: checked

        @props.onChange checked

        data = @_getAnimateData checked

        Animated.parallel([
            AnimateUtils.createTiming @state.wh,  x: data.whx, y: data.why
            AnimateUtils.createTiming @state.lt,  x: data.ltx, y: data.lty
            AnimateUtils.createTiming @state.marginLeft, data.value
        ]).start()
        return
    
    render: ()->  
        
        if @state.checked
            backgroundColor = Color.green
        else
            backgroundColor = Color.lightGray

        <View style={styles.container}>
            <View style={styles.titleContainer}>
                <Text ellipsizeMode="middle" style={styles.title}>{@props.title}</Text>
                {
                    if @props.desc
                        <Text style={styles.desc}>{@props.desc}</Text>
                    else
                        null
                }
            </View>
            <TouchableWithoutFeedback onPress={@_onPress}>
                <View style={[styles.switchContainer, {backgroundColor: backgroundColor}]}>
                    <Animated.View style={[styles.noCheckedContainer, 
                        {left: @state.lt.x, top: @state.lt.y}, 
                        {width: @state.wh.x, height: @state.wh.y}]}>
                    </Animated.View>
                    <Animated.View style={[styles.shape, {marginLeft: @state.marginLeft}]}>
                    </Animated.View>
                </View>
            </TouchableWithoutFeedback>
        </View>

styles = StyleSheet.create

    container: 
        paddingTop: 10
        paddingBottom: 10
        paddingLeft: 15
        paddingRight: 5
        flexDirection: 'row'
        backgroundColor: Color.white

    switchContainer:
        width: 52
        height: 32
        borderRadius: 16
        backgroundColor: Color.green
        borderColor: Color.gray
        borderWidth: RNWeui.pixel

    noCheckedContainer:
        position: 'absolute'
        top: RNWeui.pixel
        left: RNWeui.pixel
        borderRadius: 16
        backgroundColor: Color.white

    shape: 
        width: 31
        height: 31
        borderRadius: 16
        backgroundColor: Color.white
        borderColor: Color.lightGray
        borderWidth: RNWeui.pixel

    titleContainer:
        flex: 1
        justifyContent: 'center'

    title:
        color: Color.black
        alignItems: 'flex-start'
