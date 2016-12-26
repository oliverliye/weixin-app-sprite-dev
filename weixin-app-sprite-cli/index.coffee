fs = require 'fs'
path = require 'path'
S = require 'string'
_ = require 'underscore'

Config = require './lib/config'
outWxml = require './lib/wxml'
Wxss = require './lib/Wxss'
Template = require './lib/template'

appPath = "c:/dev/weixinapp/weixin-app-sprite-dev/test/testApp/"


appJs = fs.readFileSync appPath + Config.root

appJson = fs.readFileSync appPath + Config.rootConfig

appWxss = fs.readFileSync appPath + Config.rootWxss

appConfig = JSON.parse appJson.toString()
fs.writeFileSync "#{appPath}/RN_app_config.js", Template.createConfig appJson.toString()


# page 默认配置
defaultWindowConfig = 
    navigationBarBackgroundColor: '#000000'
    navigationBarTextStyle: 'white'
    navigationBarTitleText: ''
    backgroundColor: '#ffffff'
    backgroundTextStyle: 'dark'
    enablePullDownRefresh: false
defaultWindowConfig = _.extend {}, defaultWindowConfig, appConfig.window

# 处理page
routes = {}
for page in appConfig.pages
    pagePath = path.dirname page
    pageName = path.basename page
    pageFilePath = appPath + pagePath + '/' + pageName

    # 读取page和wxss代码
    pageCode = fs.readFileSync pageFilePath + '.js'
    cssCode = fs.readFileSync pageFilePath + '.wxss'

    fs.writeFileSync "#{appPath + pagePath}/RN_#{pageName}.js", Template.createPage pageCode.toString(), pageName


    outWxml appPath + pagePath, pageName, new Wxss cssCode.toString()

    # 转换page配置文件 .json
    if fs.existsSync pageFilePath + '.json'
        pageConfig = fs.readFileSync pageFilePath + '.json'
        routes[page] = _.extend {}, defaultWindowConfig, JSON.parse pageConfig.toString()
    else
        routes[page] = defaultWindowConfig

    routes[page].path = pagePath

    console.log routes[0]

# 输出路由配置文件
fs.writeFileSync "#{appPath}/RN_routes.js", Template.createRoute routes




