import Route from './route'

export default {

    navigateTo: (params)->
        Route.navigateTo params.url

    redirectTo: (params)->
    	Route.redirectTo params.url

    switchTab: (params)->

    navigateBack: (params)->
        Route.navigateBack()
        
}
