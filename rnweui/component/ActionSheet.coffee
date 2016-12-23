import React from 'react'
import  {
    Text
    View
    Animated
    Easing
    StyleSheet
    TouchableHighlight
    TouchableWithoutFeedback
}  from 'react-native'

import RNWeui from '../rnweui'

import AnimateUtils from '../utils/AnimateUtils'

import Icons from './Icons'
import Color from './Color'

Popup =  React.createClass

    getInitialState: ()->  top: AnimateUtils.value RNWeui.getContentHeight()

    componentDidMount: ()->
        
    getStartAnimate: ()-> AnimateUtils.createTiming @state.top, 0

    getEndAnimate: ()-> AnimateUtils.createTiming @state.top, RNWeui.getContentHeight()

    _close: ()->
        RNWeui.getModal().close()

    render: ()->  

        items = []
        for item, index  in @props.items
            items.push <View key={index} style={styles.item}>
                    <Text style={styles.itemText}>{item.text}</Text>
                </View>
                
            items.push <View key={'line'+index} style={styles.line}/>

        <Animated.View style={[styles.container, {width: RNWeui.getContentWidth(), height: RNWeui.getContentHeight(), top: this.state.top}]}>
         <TouchableWithoutFeedback onPress={@_close}>
            <View style={styles.contentCantainer}>
               {items}
            </View>
            </TouchableWithoutFeedback>
        </Animated.View>

styles = StyleSheet.create

    
    line:
        height: RNWeui.pixel
        backgroundColor: Color.lightGray

    container: 
        flex: 1
        position: 'absolute'
        justifyContent: 'flex-end'
        
    contentCantainer:
        justifyContent: 'flex-end'
        backgroundColor: Color.white

    item: 
        alignItems: 'center'
        justifyContent: 'center'
        padding: 12
    itemText: 
        color: Color.black
  
ActionSheet = 
    show:(props)->
        RNWeui.getModal().popup Popup, props,  mask: true, maskClose: true


export default ActionSheet

        