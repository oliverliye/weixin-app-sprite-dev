import React from 'react'
import  {
    View
    Text
    Image
    StyleSheet
    ScrollView
    TouchableOpacity
    Animated
}  from 'react-native'

import ToolBar from './ToolBar'

export default React.createClass

    onActionSelected: (name)->
        @refs.page.onActionSelected name

    render: ()->

        Page = this.props.page

        <View style={{flex:1}}>
            {
                if Page.showToolBar
                    <ToolBar 
                        ref="toolbar"
                        navigator={@props.navigator}
                        title={Page.title}
                        popupTitle={Page.popupTitle}
                        popupIcon={Page.popupIcon}
                        actions={Page.actions}
                        onActionSelected={@onActionSelected}
                    /> 
                else
                    null
            }
            {
                if Page.showScrollView
                    <ScrollView>
                        <Page.component navigator={@props.navigator} ref="page" route={@props.route} />
                    </ScrollView>
                else  
                    <Page.component navigator={@props.navigator} ref="page" route={@props.route} /> 
            }
        </View>