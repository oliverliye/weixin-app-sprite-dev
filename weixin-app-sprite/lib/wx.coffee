import route from './route'
import request from './api/request'


export default {

    navigateTo: (params)->
        if route.navigateTo params.url
        	params.success?()
        else
        	params.fail?()
        params.complete?()

    redirectTo: (params)->
        if route.redirectTo params.url
        	params.success?()
        else
        	params.fail?()
        params.complete?()

    switchTab: (params)->
        if route.switchTab params.url
        	params.success?()
        else
        	params.fail?()
        params.complete?()


    navigateBack: (params)->
        route.navigateBack()

    request: (params)-> 
        request params
        
}
