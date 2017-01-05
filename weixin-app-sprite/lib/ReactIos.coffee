import React from 'react'
import  {
    Navigator
}  from 'react-native'
import RNWeui from 'rnweui'
import Route from './route'
import Config from './config'


export default React.createClass

    getInitialState: ()-> _isRoot: true

    componentDidMount: ()-> 

        Route.init @refs.navigator
        
        RNWeui.BackAndroid ()=>
            return false if @state._isRoot
            @refs.navigator.pop()
            true

    _navigatorDidFocus: (route)->
        @state._isRoot = route.name is 'wxas_home'
    
    render: ()->
        <RNWeui.component.weui>
            <Navigator
                ref="navigator"
                initialRoute={Route['wxas_home']}
                onDidFocus={(route)=> @_navigatorDidFocus(route)}
                renderScene={@renderNav}/>
        </RNWeui.component.weui>

    renderNav: (route, nav)->
        Page = Route.getRoute[route.name]
        <View style={flex:1}>
            <RNWeui.component.pageview navigator={nav} page={Page}/>
        </View>

