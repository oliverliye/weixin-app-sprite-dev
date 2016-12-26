import { Platform } from 'react-native';

import App from './lib/app'
import Page from './lib/page'
import Route from './lib/route'
import Config from './lib/config'
import Wx from './lib/wx'
import WXView from './lib/ReactAndroid'

# if Platform.OS is 'ios'
# 	import WXView from './lib/ReactIos'
# else if Platform.OS is 'android'
# 	import WXView from './lib/ReactAndroid'

init = (config, routes)->
	Config.setConfig config
	Config.setRoute routes

export default {init, App, Page, Route, WXView, Wx}
