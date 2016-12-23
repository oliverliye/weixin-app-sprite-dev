import React from 'react'
import { StyleSheet } from 'react-native'

import Ionicons from 'react-native-vector-icons/Ionicons'

import FontAwesome from 'react-native-vector-icons/FontAwesome'

export default {

    type: Ionicons
    
    add: (size = 32, color = '#ffffff')-> <Ionicons name="ios-add" size={size} color={color} style={styles.style}/>

    arrowLeft: (size = 32, color = '#ffffff')-> <FontAwesome name="angle-left" size={size} color={color} style={styles.style}/>

    arrowRight: (size = 32, color = '#ffffff')-> <FontAwesome name="angle-right" size={size} color={color} style={styles.style}/>

    shop: (size = 32, color = '#ffffff')-> <FontAwesome name="shopping-bag" size={size} color={color} style={styles.style}/>

    user: (size = 32, color = '#ffffff')-> <FontAwesome name="user" size={size} color={color} style={styles.style}/>

    message: (size = 32, color = '#ffffff')-> <FontAwesome name="bell-o" size={size} color={color} style={styles.style}/>

    setting: (size = 32, color = '#ffffff')-> <FontAwesome name="cog" size={size} color={color} style={styles.style}/>

    search: (size = 32, color = '#ffffff')-> <FontAwesome name="search" size={size} color={color} style={styles.style}/>

    clearCircle: (size = 32, color = '#ffffff')-> <FontAwesome name="times-circle" size={size} color={color} style={styles.style}/>

}


styles = StyleSheet.create
    style:
        alignItems: 'center'
        justifyContent: 'center'
        fontWeight: '100'