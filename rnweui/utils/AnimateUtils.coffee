import React from 'react'
import  {
    Animated
    Easing
}  from 'react-native'

import RNWeui from '../rnweui'

export default {
 
    value: (value)-> new Animated.Value value

    valueXY: (value)-> new Animated.ValueXY value

    createTiming: (value, toValue, duration = RNWeui.getDuration())->
        Animated.timing(value, 
            toValue: toValue
            duration: duration
            easing: Easing.linear
        )

}




