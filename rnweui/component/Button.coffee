import React from 'react'
import  {
    Text
    View
    StyleSheet
    TouchableHighlight
}  from 'react-native'

import RNWeui from '../rnweui'
import Icons from './Icons'
import Color from './Color'


export default React.createClass
   
    propTypes: 
        type: React.PropTypes.oneOf ['primary', 'default', 'warn']
        formType: React.PropTypes.oneOf ['submit', 'reset']
        plain: React.PropTypes.boolean
        disable: React.PropTypes.boolean
        loading: React.PropTypes.boolean
        label: React.PropTypes.string
        onPress: React.PropTypes.func

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


        


