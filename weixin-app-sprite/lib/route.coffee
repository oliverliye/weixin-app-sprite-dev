S = require 'string'
import Config from './config'

navigator = null

stack = []


parseQuery = (queryStr)->
	query = {}
	for item in queryStr.split '&'
		unless S(item).isEmpty()
			[name, value] = item.split '='
			query[name] = value
	query

parseUrl = (url, current)->
	[uri, queryStr] = url.split '?'

	data = parseQuery queryStr unless S(queryStr).isEmpty()
	
	
	if S(uri).startsWith '/'
		name = S(uri).chompLeft('/').s.replace /\/+/g, '_'

	else
		citems = current.split /\/+/g
		uitems = uri.split /\/+/g

		for it in uitems
			continue if it is '.'
			if it is '..'
				citems.pop()
			else
				citems.push it

		name = citems.join '_'

	{name, data}


export default {

	init: (nav)-> navigator = nav

	navigateTo: (url)->
		params = parseQuery url
		route = Config.getRoute params.uri
		if route
			route['wxas_data'] = params.data
			navigator.push route
			true
		else
			false

	redirectTo: (url)->
		params = parseQuery url
		route = Config.getRoute params.uri
		if route
			route['wxas_data'] = params.data
			navigator.immediatelyResetRouteStack [route]
			true
		else
			false

	navigateBack: (delta = 1)-> 
		routes = navigator.getCurrentRoutes()
		index = routes.length
		return false if index < 0 or index - delta - 1 < 0
		navigator.popToRoute routes[index - delta - 1]
		true

	switchTab: (url)->
		params = parseQuery url
		route = Config.getRoute params.uri
}
