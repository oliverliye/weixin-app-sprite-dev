import route from './route'
import equest from './lib/request'


export default {

    navigateTo: (params)->
        route.navigateTo params.url

    redirectTo: (params)->
        route.redirectTo params.url

    switchTab: (params)->

    navigateBack: (params)->
        route.navigateBack()

    request: (params)-> 
        request params
        
}
