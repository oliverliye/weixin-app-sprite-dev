import React from 'react'
import  {
    Navigator
}  from 'react-native'
import RNWeui from 'rnweui'

View = React.createClass

    getInitialState: ()-> _isRoot: true

    componentDidMount: ()-> 

        RNWeui.BackAndroid ()=>
            return false if @state._isRoot
            @refs.navigator.pop()
            true

    _navigatorDidFocus: (route)->
        @state._isRoot = route.name is 'Home'
    
    render: ()->
        `<Weui>
            <Navigator
                ref="navigator"
                initialRoute={Route.Home}
                onDidFocus={(route)=> this._navigatorDidFocus(route)}
                renderScene={this.renderNav}/>
        </Weui>`

    renderNav: (route, nav)->
        Page = Route[route.name]
        `<View style={{flex:1,backgroundColor:'#e9eaed'}} >
            <PageView navigator={nav} page={Page} route={Route.create(nav)} />
        </View>`

export default (appPath)->

	View
