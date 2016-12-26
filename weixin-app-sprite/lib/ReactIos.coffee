

export default React.createClass

        getInitialState: ()-> _isRoot: true

        componentDidMount: ()-> 

            Route.init @refs.navigator
            
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