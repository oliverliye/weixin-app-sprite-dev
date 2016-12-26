/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import {
  AppRegistry,
} from 'react-native';

import wxas from 'weixin-app-sprite'
import config from './testApp/RN_app_config'
import routes from './testApp/RN_routes'

wxas.init config, routes

AppRegistry.registerComponent('test', () => wxas.WXView);
