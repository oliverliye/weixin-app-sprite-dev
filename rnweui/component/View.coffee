import React from 'react'
import  {
    View
}  from 'react-native'
import EventPropTypes from './EventPropTypes'
import PanResponder from './PanResponder'

export default React.createClass

    propTypes: 
        hover: React.PropTypes.bool
        hoverClass: React.PropTypes.string
        hoverStartTime: React.PropTypes.number
        hoverStayTime: React.PropTypes.number
    
    getDefaultProps: ()->
        hover: false
        hoverClass: 'none'
        hoverStartTime: 50
        hoverStayTime: 400

    getInitialState: ()->
        hoverClass: {}
	
    componentWillMount: ()->
        @isHover = (@props.hover is 'true' or @props.hover is true) and @props.hoverClass != 'none' and @props.wxasClass.hasOwnProperty(@props.hoverClass)
        config = 
            onStartShouldSetPanResponder: ()=> @isHover
            onPanResponderGrant: ()=>
                if @isHover
                    if @props.hoverStartTime > 0
                        setTimeout ()=>
                            @setState hoverClass: @props.wxasClass[@props.hoverClass]
                        , @props.hoverStartTime
                    else
                        @setState hoverClass: @props.wxasClass[@props.hoverClass]

                
            onPanResponderRelease: ()=>
                if @isHover
                    if @props.hoverStayTime > 0
                        setTimeout ()=>
                            @setState hoverClass: {}
                        , @props.hoverStayTime
                    else
                        @setState hoverClass: {}

        @_panPesponder = PanResponder @, config

    render: ()->
        if @isHover
            dom = <View style={[{flex:1}, @state.hoverClass]}>{@props.children}</View>
        else
            dom = @props.children

        <View style={@props.style} {...@_panPesponder.panHandlers} >
            {dom}
        </View>