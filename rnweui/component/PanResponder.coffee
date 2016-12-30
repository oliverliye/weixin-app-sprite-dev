import  {
    PanResponder
}  from 'react-native'
import _ from  'underscore'


export default (component, panConfig)->

	timeStamp = 0

	handler = component.props

	config = 
		onStartShouldSetPanResponder: ()->
			handler.hasOwnProperty 'bindtouchstart' || 
			handler.hasOwnProperty 'catchtouchstart' || 
			handler.hasOwnProperty 'bindtap' || 
			handler.hasOwnProperty 'catchtap' || 
			handler.hasOwnProperty 'bindlongtap' ||
			handler.hasOwnProperty 'catchlongtap'

		onMoveShouldSetPanResponder: (e, gestureState)-> 
			handler.hasOwnProperty 'bindtouchmove' || handler.hasOwnProperty 'catchtouchmove'

		onPanResponderReject: (e, gestureState)->
			panConfig.onPanResponderReject?(e, gestureState)

		onPanResponderGrant: (e, gestureState)->
			panConfig.onPanResponderGrant?(e, gestureState)
		
		onPanResponderRelease: (e, gestureState)->
			panConfig.onPanResponderRelease?(e, gestureState)

		onPanResponderMove: (e, gestureState)->
			panConfig.onPanResponderMove?(e, gestureState)

			if handler.hasOwnProperty 'bindtouchmove'
				handler.bindtouchmove()
			else if handler.hasOwnProperty 'catchtouchmove'
				handler.catchtouchmove()

		onPanResponderStart: (e, gestureState)->
			panConfig.onPanResponderStart?(e, gestureState)

			timeStamp = new Date().getTime()
			if handler.hasOwnProperty 'bindtouchstart'
				handler.bindtouchstart()
			else if handler.hasOwnProperty 'catchtouchstart'
				handler.catchtouchstart()

		onPanResponderEnd: (e, gestureState)->
			panConfig.onPanResponderEnd?(e, gestureState)

			if handler.hasOwnProperty 'catchtouchend'
				handler.catchtouchend()
			else if handler.hasOwnProperty 'bindtouchend'
				handler.bindtouchend()

			if (new Date().getTime()) - timeStamp > 350
				if handler.hasOwnProperty 'catchtap'
					handler.catchtap()
				else if handler.hasOwnProperty 'bindtap'
					handler.bindtap() 
			else
				if handler.hasOwnProperty 'bindlongtap'
					handler.catchlongtap()
				else if handler.hasOwnProperty 'catchlongtap'
					handler.bindlongtap() 

		onResponderTerminate: ()->
			panConfig.onResponderTerminate?(e, gestureState)

			if handler.hasOwnProperty 'bindtouchcancel'
				handler.catchtouchcancel()
			else if handler.hasOwnProperty 'catchtouchcancel'
				handler.bindtouchcancel() 


	PanResponder.create config


















	PanResponder
