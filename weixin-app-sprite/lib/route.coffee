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
		navigator.resetTo route

	navigateBack: (delta = 1)-> 
		routes = navigator.getCurrentRoutes()
		index = routes.length
		return if index < 0 or index - delta < 0

		navigator.popToRoute routes[index - delta]

	switchTab: (params)->
}
