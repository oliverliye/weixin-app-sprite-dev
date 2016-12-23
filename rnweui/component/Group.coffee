import React from 'react'
import  {
    Text
    View
    StyleSheet
}  from 'react-native'

import RNWeui from '../rnweui'
import Icons from './Icons'
import Color from './Color'

export default React.createClass
   
    render: ()->  

        dom = []

        if @props.children

            if @props.children instanceof Array
                for item, index in @props.children
                    dom.push item
                    dom.push <View key={index} style={styles.line}/>
                dom.pop()
            else
                dom = @props.children
                

        <View style={styles.container}>
            <View style={styles.titleContainer}>
                <Text style={styles.title}>{@props.title}</Text>
            </View>
            {dom}
        </View>
        

styles = StyleSheet.create

    container: 
        marginTop: 10
        marginBottom: 10
        paddingBottom: 10
        backgroundColor: Color.backgroundColor

    line:
        opacity: 0.5
        height: RNWeui.pixel
        #backgroundColor: Color.lightGray
        marginLeft: 15

    titleContainer:
        paddingTop: 5
        paddingBottom: 5
        paddingLeft: 15
        
    title:
        color: Color.gray
        alignItems: 'flex-start'

        


