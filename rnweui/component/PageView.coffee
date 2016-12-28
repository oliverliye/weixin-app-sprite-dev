import React from 'react'
import  {
    View
    StyleSheet
    ScrollView
}  from 'react-native'

import ToolBar from './ToolBar'

export default React.createClass

    onActionSelected: (name)->
        @refs.page.onActionSelected name

    render: ()->

        Component = @props.component

        <View style={{flex:1, backgroundColor: @props.backgroundColor}}>
            {
                if @props.showToolBar
                    <ToolBar 
                        ref="toolbar"
                        navigator={@props.navigator}
                        backgroundColor={@props.navigationBarBackgroundColor}
                        onActionSelected={@onActionSelected}/> 
                else
                    null
            }
            {
                if @props.showScrollView
                    <ScrollView>
                        <Component ref="page"/>
                    </ScrollView>
                else  
                    <Component ref="page"/>
            }
        </View>

# popupTitle={Page.popupTitle}
# popupIcon={Page.popupIcon}
# actions={Page.actions}