import React from 'react'
import  {
    View
    Navigator
    ScrollView
}  from 'react-native'
import RNWeui from 'rnweui'
import Route from './route'
import Config from './config'


export default React.createClass

    getInitialState: ()-> isRoot: true

    componentDidMount: ()-> 

        Route.init @refs.navigator
        
        RNWeui.backAndroid ()=>
            return false if @state._isRoot
            @refs.navigator.pop()
            true

    navigatorDidFocus: (route)->
        @state.isRoot = route.name is 'wxas_home'
    
    render: ()->
        <RNWeui.component.weui>
            <Navigator
                ref="navigator"
                initialRoute={Config.getRoute(Config.getRoute 'wxas_home')}
                onDidFocus={(route)=> @navigatorDidFocus(route)}
                renderScene={@renderNav}/>
        </RNWeui.component.weui>

    renderNav: (route, nav)->
        Page = Config.getRoute route.wxas_name
        <View style={flex:1, backgroundColor: Page.backgroundColor}>
            <RNWeui.component.toolbar 
                navigator={nav} 
                title={Page.navigationBarTitleText}
                navigationBarTextStyle={Page.navigationBarTextStyle}
                backgroundColor={Page.navigationBarBackgroundColor}/>
            {
                if Page.disableScroll
                    <Page.wxas_component ref="page"/>
                else
                    <ScrollView>
                        <Page.wxas_component ref="page"/>
                    </ScrollView>
            }
        </View>

