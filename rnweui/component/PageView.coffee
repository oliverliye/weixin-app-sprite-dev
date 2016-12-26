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

        Page = @props.page

        <View style={{flex:1, backgroundColor: Page.backgroundColor}}>
            {
                if Page.showToolBar
                    <ToolBar 
                        ref="toolbar"
                        navigator={@props.navigator}
                        navigationBarTitleText={Page.navigationBarTitleText}
                        navigationBarTextStyle={Page.navigationBarTextStyle}
                        navigationBarBackgroundColor={Page.navigationBarBackgroundColor}
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
                        <Page.component navigator={@props.navigator} ref="page"/>
                    </ScrollView>
                else  
                    <Page.component navigator={@props.navigator} ref="page"/> 
            }
        </View>