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
        bgColor: null

	
    componentWillMount: ()->

        isHover = ()=> (@props.hover = true or @props.hover = 'true') and @props.hoverClass != 'none' and @props.wxasClass.hasOwnProperty(@props.hoverClass)
       
        config = 
            onStartShouldSetPanResponder: ()=> isHover()
            onPanResponderGrant: ()=>
                if isHover()
                    if @props.hoverStartTime > 0
                        setTimeout ()=>
                            @setState bgColor: 'green'#@props.wxasClass[@props.hoverClass]
                        , @props.hoverStartTime
                    else
                        @setState bgColor: @props.wxasClass[@props.hoverClass]

                
            onPanResponderRelease: ()=>
                if isHover()
                    if @props.hoverStayTime > 0
                        setTimeout ()=>
                            @setState bgColor: null
                        , @props.hoverStayTime
                    else
                        @setState bgColor: null

        @_panPesponder = PanResponder @, config

    render: ()->

        <View style={@props.style} {...@_panPesponder.panHandlers} >
            <View style={{flex:1,backgroundColor:@state.bgColor}}>
            {@props.children}
            </View>
        </View>