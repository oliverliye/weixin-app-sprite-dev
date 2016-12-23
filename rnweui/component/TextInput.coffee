import React from 'react'
import  {
    View
    Text
    Image
    StyleSheet
    TouchableOpacity
    TouchableHighlight
    TouchableWithoutFeedback
    TextInput
}  from 'react-native'

import Color from './Color'
import Icons from './Icons'

export default React.createClass

    getInitialState: ()->
        value: @props.defaultValue
        showClear: if @props.defaultValue and @props.defaultValue.length> 0 then true else false
    
    _onChangeText: (value)->
        @state.value = value
        @setState showClear: @_hasText()  

    _onFocus: ()->
        if @_hasText()
            @setState showClear: true

    _onBlur: ()->
        if @_hasText()
            @setState showClear: true

    _clear: ()->
        if @_hasText()
            @state.value = ''
            @refs.textInput.clear() 
            @setState showClear: false


    _hasText: ()-> if @state.value and  @state.value.length > 0 then true else false

    render: ()->
        action = @props.action
        show = []
        <View style={styles.container}>
            {
                if @props.label
                    <View style={styles.labelContainer}>
                        <Text style={styles.label}>
                            {@props.label}
                        </Text>
                    </View>
                else
                    null
            }
           
            <View style={styles.inputContainer}>
                <TextInput
                    ref="textInput"
                    {...@props}
                    clearButtonMode="never"
                    underlineColorAndroid="transparent"
                    onChangeText={@_onChangeText}
                    onFocus={@_onFocus}
                    onBlur={@_onBlur}
                    />
            </View>
            {
                if @state.showClear
                    <TouchableWithoutFeedback style={{flex:1}} onPress={@_clear}>
                        <View style={styles.clearContainer}>
                            {Icons.clearCircle(16, Color.darkGray)}
                        </View>
                    </TouchableWithoutFeedback>
                else
                    null
            }
            
        </View>

styles = StyleSheet.create
    container:
        paddingLeft: 15
        paddingRight: 10
        flexDirection: 'row'
        backgroundColor: Color.white

    labelContainer: 
        alignItems: 'flex-end'
        justifyContent: 'center'

    label:
        color: Color.black

    inputContainer:
        flex:1

    clearContainer:
        width: 24
        alignItems: 'center'
        justifyContent: 'center'

