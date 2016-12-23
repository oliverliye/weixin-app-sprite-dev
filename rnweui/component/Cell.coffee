import React from 'react'
import  {
    Text
    View
    StyleSheet
    TouchableHighlight
}  from 'react-native'

import Icons from './Icons'
import Color from './Color'

export default React.createClass

    propTypes: 
        # TODO: icon类型限制有问题
        #icon: React.PropTypes.instanceOf Icons.type
        title: React.PropTypes.string
        onPress: React.PropTypes.func
      
    render: ()->  

        if @props.children
            dom = <View style={styles.container}>{@props.children}</View>
        else
            dom = <View style={styles.container}>
                    {
                        if @props.icon 
                            <View style={styles.iconContainer}>
                                {@props.icon}
                            </View>
                        else 
                            null
                    }

                    {
                        if @props.title 
                            <View style={styles.titleContainer}>
                                <Text ellipsizeMode="middle" style={styles.title}>{@props.title}</Text>
                                {
                                    if @props.desc
                                        <Text style={styles.desc}>{@props.desc}</Text>
                                    else
                                        null
                                }
                                
                            </View>
                        else
                            null
                    }
                    {
                        if @props.value
                            <View style={styles.valueContainer}>
                                <Text style={styles.value}>{@props.value}</Text>
                            </View>
                        else
                            null
                    }
                    {
                        if @props.onPress
                            <View style={styles.arrow}>
                                {Icons.arrowRight(16, '#888')}
                            </View>
                        else
                            null
                    }
                </View>
            

        if @props.onPress
            return <TouchableHighlight onStartShouldSetResponder={()=>true} onMoveShouldSetResponder={()=>true} onPress={@props.onPress}>{dom}</TouchableHighlight>
        else
            return <View >{dom}</View>

styles = StyleSheet.create

    container: 
        paddingTop: 10
        paddingBottom: 10
        paddingLeft: 15
        paddingRight: 5
        flexDirection: 'row'
        backgroundColor: Color.white

    iconContainer:
        marginRight: 10
        alignItems: 'center'
        justifyContent: 'center'

    titleContainer:
        flex: 1
        justifyContent: 'center'

    title:
        color: Color.black
        alignItems: 'flex-start'

    desc:
        color: Color.gray
        fontSize: 12
        alignItems: 'flex-start'

    valueContainer:
        marginLeft: 10
        marginRight: 10
        justifyContent: 'center'

    value:
        color: Color.gray
        alignItems: 'flex-end'

    arrow:
        width:16
        alignItems: 'center'
        justifyContent: 'center'

        


