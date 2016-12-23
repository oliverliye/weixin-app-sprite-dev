/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React from 'react';
import {
  AppRegistry,
  Text
} from 'react-native';

import Index from './testApp/pages/index/RN_index'

test = React.createClass({
  render: function() {
    //console.log(Index);
    var a = <Text>aaa</Text>
    console.log(Text);
    return (<Index/>);
  }
});

AppRegistry.registerComponent('test', () => test);
