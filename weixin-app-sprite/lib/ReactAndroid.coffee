import React from 'react'
import  {
    Navigator
}  from 'react-native'
import RNWeui from 'rnweui'

View = null

create = (appPath)->

	return View if View


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
	        `<RNWeui.component.weui>
	            <Navigator
	                ref="navigator"
	                initialRoute={Route.Home}
	                onDidFocus={(route)=> this._navigatorDidFocus(route)}
	                renderScene={this.renderNav}/>
	        </RNWeui.component.weui>`

	    renderNav: (route, nav)->
	        Page = Route[route.name]
	        `<View style={{flex:1,backgroundColor:'#e9eaed'}} >
	            <RNWeui.component.pageview navigator={nav} page={Page} route={Route.create(nav)} />
	        </View>`

	View


export default (appPath)-> create appPath

