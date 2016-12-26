import { Platform } from 'react-native';

import App from './lib/app'
import Page from './lib/page'
import Route from './lib/route'
import Config from './lib/config'
import Wx from './lib/wx'

WXView = Platform.select(
 	ios: ()-> require './lib/ReactAndroid'
 	android: ()-> require './lib/ReactIos'
)()

init = (config, routes)->
	Config.setConfig config
	Config.setRoute routes

export default {init, App, Page, Route, WXView, Wx}
