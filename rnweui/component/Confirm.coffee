import React from 'react'
import  {
    Text
    View
    Animated
    Easing
    StyleSheet
    TouchableHighlight
}  from 'react-native'

import RNWeui from '../rnweui'

import Icons from './Icons'
import Color from './Color'

Popup =  React.createClass

    propTypes:
        message: React.PropTypes.string

    getDefaultProps: ()->
        title: 'Alert'
        okButtonText: 'OK'
        cancelButtonText: 'OK'


    getInitialState: ()-> 

        maskOpacity = new Animated.Value 0

    getStartAnimate: ()-> 
        Animated.timing(@state.maskOpacity, 
            toValue: 0.6
            duration: 300
        )

    getEndAnimate: ()->
        Animated.timing(@state.maskOpacity, 
            toValue: 0
            duration: 300
        )

      
    render: ()->  

        <Animated.View style={[styles.container, {opacity: @state.maskOpacity}]}>
            <View style={styles.contentCantainer}>
               <Text style={styles.title}>{@props.title}</Text>
               <Text style={styles.message}>{@props.message}</Text>
            </View>
           <View style={styles.line}/>
           <View style={styles.buttonGroupCantainer}>
	           <TouchableHighlight style={styles.buttonCantainer} underlayColor={Color.lightGray} onPress={()=>RNWeui.getModal().close()}>
	                <Text style={styles.button}>{@props.okButtonText}</Text>
	           </TouchableHighlight>
	           <TouchableHighlight style={styles.buttonCantainer} underlayColor={Color.lightGray} onPress={()=>RNWeui.getModal().close()}>
	                <Text style={styles.button}>{@props.cancelButtonText}</Text>
	           </TouchableHighlight>
           </View>
        </Animated.View>

styles = StyleSheet.create

    container: 
        borderRadius: 3
        width: RNWeui.windowWidth * 0.8
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

    buttonGroupCantainer:
    	justifyContent: 'w'

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
    show:(props)->
        RNWeui.getModal().popup Popup, props, align: 'center', mask: true


export default Alert

        


