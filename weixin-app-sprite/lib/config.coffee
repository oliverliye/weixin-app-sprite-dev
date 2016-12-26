
configData = null

routeData = null

export default {

    setConfig: (config)-> configData = config

    getConfig: (name)-> configData[name]

    setRoute: (routes)-> routeData = routes

    getRoute: (pageName)-> routeData[pageName]

    getRoutes: ()-> routeData[pageName]
    	
}