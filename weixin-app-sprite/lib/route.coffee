
Routes = null

Navigaotr = null

export default {

	init: (navigator, routes)-> 
		Navigaotr = navigator
		Routes = routes

	navigateTo: (params)->


	redirectTo: (params)->
		Navigaotr.push()

	switchTab: (params)->


	navigateBack: (delta = 1)-> 
		Navigaotr.pop()


}
