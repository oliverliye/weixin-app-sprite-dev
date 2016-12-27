import React from 'react'
import  {
    View
    Navigator
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
        @state.isRoot = route.name is '__home__'
    
    render: ()->
        <RNWeui.component.weui>
            <Navigator
                ref="navigator"
                initialRoute={Config.getRoute(Config.getRoute '__home__')}
                onDidFocus={(route)=> @navigatorDidFocus(route)}
                renderScene={@renderNav}/>
        </RNWeui.component.weui>

    renderNav: (route, nav)->
        Page = Config.getRoute route.name
        <View style={flex:1}>
            <RNWeui.component.pageview navigator={nav} page={Page}/>
        </View>

