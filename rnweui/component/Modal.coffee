import React from 'react'
import  {
    View
    StyleSheet
    TouchableWithoutFeedback
    Animated
    Easing
}  from 'react-native'

import RNWeui from '../rnweui'
import Color from './Color'


Modal = React.createClass

    getInitialState: ()-> 
        maskOpacity: new Animated.Value 0

    componentDidMount: ()->

        animateArray = []

        animateArray.push startAnimate  if startAnimate = @refs.popup.getStartAnimate?()

        animateArray.push Animated.timing @state.maskOpacity,  toValue: 0.6, duration: RNWeui.getDuration()

        Animated.parallel(animateArray).start()

    close: (callback)->

        animateArray = []

        animateArray.push endAnimate  if endAnimate = @refs.popup.getEndAnimate?()

        if @props.mask is true
            animateArray.push Animated.timing @state.maskOpacity,  toValue: 0, duration: RNWeui.getDuration() 

        Animated.parallel(animateArray).start ()=>
            @props.parent.setState show: false

    
    render: ()->

        contentStyle = [styles.content]
        if @props.align is 'center'
            contentStyle.push alignItems: 'center', justifyContent: 'center'

        if @props.mask is true
            maskStyle =  backgroundColor: Color.black


        if @props.maskClose
            close = ()=> this.close()
        else
            close = ()->


        sizeStyle =
            width: RNWeui.getContentWidth()
            height: RNWeui.getContentHeight()

        contentStyle.push sizeStyle

        Popup = @props.popup 

        <View style={{flex:1}}>
            <TouchableWithoutFeedback onPress={close}>
                <Animated.View style={[styles.mask, maskStyle, sizeStyle, {opacity: this.state.maskOpacity}]}></Animated.View>
            </TouchableWithoutFeedback>
            <View style={contentStyle}>
                <Popup ref="popup" {...@props.popupProps}/>
            </View>
        </View>


export default React.createClass
   
    getInitialState: ()->  show: false

    isShow: ()-> @state.show

    popup: (component, componentProps, modalProps = {align: 'default', mask: false, maskClose: false})->
    	return if @state.show

    	@setState 
            show: !@state.show
            component: component
            componentProps: componentProps
            modalProps: modalProps


    close: ()-> @refs.modal.close()
    
    render: ()->   

        <View style={{position: 'absolute', top: 0, left: 0,width: RNWeui.getContentWidth(), height: if @state.show then RNWeui.getContentHeight() else 0}}>
            {
                if @state.show 
                    <Modal ref="modal" parent={@} {...@.state.modalProps} popup={@state.component} popupProps={@state.componentProps}/>
                else
                    null
            }
        </View>

styles = StyleSheet.create

    mask: 
        position: 'absolute'
        top: 0
        left: 0

    content:
        position: 'absolute'
        top: 0
        left: 0


