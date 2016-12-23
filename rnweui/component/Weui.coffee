import React from 'react'
import  {
    View
}  from 'react-native'

import Rnweui from '../rnweui'
import Modal from './Modal'

export default React.createClass

    componentDidMount: ()-> 
        Rnweui.setModal ()=> @refs.modal
    
    onLayout: (event)->
        console.log "weui:" + event.nativeEvent.layout.width
        console.log "weui:" + event.nativeEvent.layout.height
        Rnweui.setContentWidth event.nativeEvent.layout.width
        Rnweui.setContentHeight event.nativeEvent.layout.height

    render: ()->
        <View style={{flex:1}} onLayout={this.onLayout} >
            {this.props.children}
            <Modal ref="modal"/>
        </View>


