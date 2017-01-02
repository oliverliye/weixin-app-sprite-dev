import Config from './config'

navigator = null

stack = []

export default {

	init: (nav)-> navigator = nav

	navigateTo: (pageName)->
		route = Config.getRoute pageName
		navigator.push route

	redirectTo: (pageName)->
		route = Config.getRoute pageName
		navigator.immediatelyResetRouteStack [route]

	navigateBack: (delta = 1)-> 
		routes = navigator.getCurrentRoutes()
		index = routes.length
		return if index < 0 or index - delta - 1 < 0
		navigator.popToRoute routes[index - delta - 1]

	switchTab: (params)->
}
