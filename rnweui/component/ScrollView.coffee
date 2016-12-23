import React from 'react'
import  {
    Text
    View
    Animated
    Easing
    StyleSheet
    TouchableHighlight
    PanResponder
}  from 'react-native'

import RNWeui from '../rnweui'


export default React.createClass

    # propTypes: 
    #     width: React.PropTypes.number
    #     height: React.PropTypes.number

    getInitialState: ()-> 
        
        top: new Animated.Value 0
        scrollState: 'none'
        viewHeight: null

    valueListen: (value)->

        return if @state.scrollState isnt 'decay'
        if value.value > 0
            @state.top.stopAnimation() 
            @_toTop()
        else if Math.abs(value.value) > Math.abs (500 - @state.viewHeight)
            @state.top.stopAnimation() 
            @_toBottom()

    _toTop: ()->
        @state.scrollState = 'toTop'
        Animated.timing(@state.top, {
            toValue: 0
        }).start (ret)=>  @state.scrollState = 'none' if ret.finished is true  

    _toBottom: ()->
        @state.scrollState = 'toBottom'
        Animated.timing(@state.top, {
            toValue: 500 - @state.viewHeight
        }).start (ret)=>  @state.scrollState = 'none' if ret.finished is true     

    _decaying: (velocity)->
        @state.scrollState = 'decay'
        Animated.decay(@state.top, {
            velocity: velocity
        }).start (ret)=>  
            @state.scrollState = 'none' if ret.finished is true
            if @state.top._value > 0 
                @_toTop()

    componentWillMount: ()->

        @state.top.removeAllListeners()

        @state.top.addListener @valueListen

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
    
    componentDidMount: ()->

    onLayout: (event)->
        @state.viewHeight = event.nativeEvent.layout.height
        #@setState viewHeight: event.nativeEvent.layout.height
    render: ()->
        <View style={styles.container}>
            <Animated.View onLayout={@onLayout}
              style={[styles.square,{top:@state.top}]} 
              {...@_panResponder.panHandlers}>
                {@props.children}
            </Animated.View>
        </View>

    componentWillUnmount: ()->
         @state.top.removeAllListeners()

styles = StyleSheet.create
    container:   
        width: 360
        height: 500
        overflow: 'hidden'
        backgroundColor: 'red'

    block:   
        width: 320
        height: 500
        backgroundColor: 'green'

    square: 
        position: 'absolute'
        top: 0
        left: 0
        right: 0
        minHeight: 500
        backgroundColor: 'blue'


