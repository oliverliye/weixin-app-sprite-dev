import React from 'react'
import  {
    View
    Text
    Image
    StyleSheet
    TouchableOpacity
    StatusBar
    TouchableWithoutFeedback
    Animated
    Easing
}  from 'react-native'

import Icons from './Icons'

import Color from './Color'

import Rnweui from '../rnweui'

import AnimateUtils from '../utils/AnimateUtils'

export default ToolBar = React.createClass

    getInitialState: ()->
        always = []
        hidden = []
        if @props.actions
            for item in @props.actions
                always.push item if item.type is 'always'
                hidden.push item if item.type is 'hidden'
        {always, hidden}

    popup: ()-> 
        modal = Rnweui.getModal()
        props = 
            actions: @state.hidden
            onActionSelected: ()=> @props.onActionSelected
            onClose: ()-> modal.close()
        modal.popup Popup, props, maskClose: true          

    _selected: (name)-> @props.onActionSelected? name

    render: ()->     

        showAlways = []

        for item, index in @state.always
            name = item.name
            if item.title or item.icon

                if item.icon
                    title = <View style={styles.actionItem}>
                            {item.icon}
                        </View>
                else
                    title = <View style={styles.alwaysItem}>
                            <Text style={styles.title}>{item.title}</Text>
                        </View>

                do (name) =>
                    showAlways.push <TouchableWithoutFeedback key={'always' + index} onPress={ ()=> @_selected(name) }>
                                        <View style={styles.alwaysItem}>
                                            {title}
                                        </View>
                                    </TouchableWithoutFeedback>
                    (name)

        if @props.popupTitle or @props.popupIcon

            if @props.popupIcon
                popupTitle = @props.popupIcon
            else
                popupTitle = <Text style={styles.textColor}>{@props.popupTitle}</Text>

            showPopupTitle = <TouchableOpacity key={'hiddenTitle'} onPress={@popup}>
                                <View style={styles.actionItem}>
                                    {popupTitle}
                                </View>
                            </TouchableOpacity>
                    
        <View style={[styles.container, {backgroundColor:@props.navigationBarBackgroundColor}]}>
            {
                if @props.navigator
                    <View style={styles.navContainer}>
                        <TouchableOpacity onPress={()=>@props.navigator.pop()}>
                            <View style={styles.navIcon}>
                                {Icons.arrowLeft()}
                            </View>
                        </TouchableOpacity> 
                    </View>
                else 
                    <View style={styles.navContainer}/>
            }
            <View style={styles.titleContainer}>
                <Text style={[styles.title, {color:@props.navigationBarTextStyle}]}>{@props.title}</Text>
            </View> 
            <View style={styles.actionContainer}>
                {showAlways}
                {showPopupTitle}
            </View>
        </View>
        

Popup = React.createClass

    getInitialState: ()->  maskOpacity: AnimateUtils.value 0
       
    _selected: (name)->
        @props.onActionSelected? name
        @props.onClose()

    # getStartAnimate: ()-> AnimateUtils.createTiming @state.maskOpacity, 1

    # getEndAnimate: ()-> AnimateUtils.createTiming @state.maskOpacity, 0
    
    render: ()->

        show = []
        for item, index in @props.actions
            name = item.name
            do (name) =>
                show.push <TouchableWithoutFeedback key={'hidden' + index} onPress={ ()=> @_selected(name) }>
                                <View style={styles.popupItem}>
                                    <View style={styles.popupIcon}>
                                        {item.icon}
                                    </View>
                                    <View style={styles.popupItemTitle}>
                                        <Text style={styles.textColor}>{item.title}</Text>
                                    </View>
                                </View>
                            </TouchableWithoutFeedback>
                show.push <View key={'line' + index} style={styles.line} />
                (name)     

        show.pop()

        <TouchableWithoutFeedback onPress={@props.onClose}>
            <View style={{alignItems: 'flex-end'}}>
                <View style={{width:12,height:12, transform:[{rotate:'45deg'}],backgroundColor:Color.lightBlack,marginTop: 55,marginRight: 15}}/>
                <View style={styles.popup}>
                    {show}
                </View>
            </View>
        </TouchableWithoutFeedback>

toolbarHeight = 50

styles = StyleSheet.create

    textColor:
        color:'#FFFFFF'

    container: 
        height: toolbarHeight
        flexDirection: 'row'
        backgroundColor: Color.lightBlack

    titleContainer: 
        flex: 2
        height: toolbarHeight
        alignItems: 'center'
        justifyContent: 'center'
    title:
        fontSize: 16
        color: Color.white

    navContainer: 
        flex: 1
        height: toolbarHeight
        justifyContent: 'center'

    navIcon:
        width: 48
        height: toolbarHeight
        alignItems: 'center'
        justifyContent: 'center'

    actionContainer: 
        flex:1
        marginLeft: 5
        height: toolbarHeight
        flexDirection: 'row'
        alignItems: 'flex-end'
        justifyContent: 'flex-end'

    alwaysItem: 
        height: toolbarHeight
        alignItems: 'center'
        justifyContent: 'center'

    actionItem:
        width: 48
        height: toolbarHeight
        alignItems: 'center'
        justifyContent: 'center'

    popup:
        marginTop: -6
        marginRight: 5
        backgroundColor: Color.lightBlack
        flexDirection: 'column'

    popupItem:
        flexDirection: 'row'
        flex: 1
        height: 48
        paddingTop: 10
        paddingBottom: 10
        paddingRight: 10

    popupIcon:
        width:48
        alignItems: 'center'
        justifyContent: 'center'
    
    popupItemTitle:
        alignItems: 'center'
        justifyContent: 'center'

    line:
        flex: 1
        height: 1
        marginLeft: 10
        marginRight: 10
        backgroundColor: Color.gray

