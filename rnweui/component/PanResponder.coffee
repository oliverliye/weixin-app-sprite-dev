import  {
    PanResponder
}  from 'react-native'



export default (component, panConfig = {})->

	timeStamp = 0

	handler = component.props

	config = 
		onStartShouldSetPanResponder: ()->
			panConfig.onStartShouldSetPanResponder?() ||
			handler.hasOwnProperty('bindtouchstart') || 
			handler.hasOwnProperty('catchtouchstart') || 
			handler.hasOwnProperty('bindtap') || 
			handler.hasOwnProperty('catchtap') || 
			handler.hasOwnProperty('bindlongtap') ||
			handler.hasOwnProperty('catchlongtap') 

		onMoveShouldSetPanResponder: (e, gestureState)-> 
			handler.hasOwnProperty 'bindtouchmove' || handler.hasOwnProperty 'catchtouchmove'

		onPanResponderReject: (e, gestureState)->
			panConfig.onPanResponderReject?(e, gestureState)

		onPanResponderGrant: (e, gestureState)->
			timeStamp = new Date().getTime()
			panConfig.onPanResponderGrant?(e, gestureState)

			if handler.hasOwnProperty 'bindtouchstart'
				handler.bindtouchstart()
			else if handler.hasOwnProperty 'catchtouchstart'
				handler.catchtouchstart()
		
		onPanResponderRelease: (e, gestureState)->
			panConfig.onPanResponderRelease?(e, gestureState)
			if handler.hasOwnProperty 'catchtouchend'
				handler.catchtouchend()
			else if handler.hasOwnProperty 'bindtouchend'
				handler.bindtouchend()

			if (new Date().getTime()) - timeStamp > 350
				if handler.hasOwnProperty 'catchlongtap'
					handler.catchlongtap()
				else if handler.hasOwnProperty 'bindlongtap'
					handler.bindlongtap() 
			else
				if handler.hasOwnProperty 'catchtap'
					handler.catchtap()
				else if handler.hasOwnProperty 'bindtap'
					handler.bindtap() 

		onPanResponderMove: (e, gestureState)->
			panConfig.onPanResponderMove?(e, gestureState)

			if handler.hasOwnProperty 'bindtouchmove'
				handler.bindtouchmove()
			else if handler.hasOwnProperty 'catchtouchmove'
				handler.catchtouchmove()

		onPanResponderStart: (e, gestureState)->
			panConfig.onPanResponderStart?(e, gestureState)

		onPanResponderEnd: (e, gestureState)->
			panConfig.onPanResponderEnd?(e, gestureState)



		onResponderTerminate: ()->
			panConfig.onResponderTerminate?(e, gestureState)

			if handler.hasOwnProperty 'bindtouchcancel'
				handler.catchtouchcancel()
			else if handler.hasOwnProperty 'catchtouchcancel'
				handler.bindtouchcancel() 


	PanResponder.create config
