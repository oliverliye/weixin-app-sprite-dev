import React from 'react'
import  {
    Text
    View
    Animated
    StyleSheet
    TouchableHighlight
}  from 'react-native'

import RNWeui from '../rnweui'

import AnimateUtils from '../utils/AnimateUtils'

import Icons from './Icons'
import Color from './Color'

Popup =  React.createClass

    propTypes:
        message: React.PropTypes.string

    getDefaultProps: ()->
        title: 'Alert'
        buttonText: 'OK'

    getInitialState: ()->  maskOpacity: AnimateUtils.value 0

    getStartAnimate: ()-> AnimateUtils.createTiming @state.maskOpacity, 1

    getEndAnimate: ()-> AnimateUtils.createTiming @state.maskOpacity, 0

    render: ()->
        <Animated.View style={[styles.container, {width: RNWeui.getScreenWidth() * 0.8, opacity: @state.maskOpacity}]}>
            <View style={styles.contentCantainer}>
               <Text style={styles.title}>{@props.title}</Text>
               <Text style={styles.message}>{@props.message}</Text>
            </View>
           <View style={styles.line}/>
           <TouchableHighlight style={styles.buttonCantainer} underlayColor={Color.lightGray} onPress={()-> RNWeui.getModal().close()}>
                <Text style={styles.button}>{@props.buttonText}</Text>
           </TouchableHighlight>
        </Animated.View>

styles = StyleSheet.create

    container:
        borderRadius: 3
        justifyContent: 'center'
        backgroundColor: Color.white
    
    line:
        height: RNWeui.pixel
        backgroundColor: Color.lightGray

    contentCantainer: 
       padding: 20

    title:
        color: Color.black
        alignSelf: 'center'
        justifyContent: 'center'
        fontSize: 17
        marginBottom: 10

    message:
        color: Color.gray
        alignSelf: 'center'
        justifyContent: 'center'
        fontSize: 15
        marginBottom: 5

    buttonCantainer: 
        flex: 1
        padding: 10 

    button:
        color: Color.green
        alignSelf: 'center'
        justifyContent: 'center'
        fontSize: 17

    titleContainer:
        paddingTop: 5
        paddingBottom: 5
        paddingLeft: 15
  
Alert = 
    show: (props)->
        RNWeui.getModal().popup Popup, props, align: 'center', mask: true


export default Alert

        


