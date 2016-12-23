import React from 'react'

# react-native 保留方法
pageReservedMethod = [
	'getDefaultProps'
	'getInitialState'
	'componentWillMount'
	#'render'
	'componentDidMount'
	'componentWillReceiveProps'
	'shouldComponentUpdate'
	'componentWillUpdate'
	'componentDidUpdate'
	'componentWillUnmount'
	'setData'
]

export default (content)->

	data = content.data

	delete content.data

	cls = 
		getInitialState: ()-> data

		setData: (data)-> @setState data

		componentWillMount: ()-> 
			@onLoad?()
			@onReady?()

		componentHide: ()-> 
			@onHide?()

		componentDidMount: ()->
			@onShow?()

		componentDidUpdate: ()->
			@onShow?()

		componentWillUnmount: ()->
			@onUnload?()


	for key, value of content

		if pageReservedMethod.indexOf('key') >= 0
			throw "方法 <#{key}> 是保留方法，不能使用！"
		else
			cls[key] = value

	React.createClass(cls)