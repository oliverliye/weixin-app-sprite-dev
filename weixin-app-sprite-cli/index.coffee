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

pages = appConfig.pages

routes = {}

# page 默认配置
defaultWindowConfig = 
    navigationBarBackgroundColor: '#000000'
    navigationBarTextStyle: 'white'
    navigationBarTitleText: ''
    backgroundColor: '#ffffff'
    backgroundTextStyle: 'dark'
    enablePullDownRefresh: false
defaultWindowConfig = _.extend defaultWindowConfig, appConfig.window

# 处理page

pageList = []

for page in pages
    pagePath = path.dirname page
    pageName = path.basename page
    pageFilePath = appPath + pagePath + '/' + pageName

    # 读取page和wxss代码
    pageCode = fs.readFileSync pageFilePath + '.js'
    cssCode = fs.readFileSync pageFilePath + '.wxss'


    outWxml appPath + pagePath, pageName, new Wxss cssCode.toString()

    #fs.writeFileSync "#{appPath + pagePath}/RN_#{pageName}.js", Template.createPage pageCode, pageName

    # 转换page配置文件 .json
    if fs.existsSync pageFilePath + '.json'
        pageConfig = fs.readFileSync pageFilePath + '.json'
        routes[pageName] = _.extend defaultWindowConfig, JSON.parse pageConfig.toString()
    else
        routes[pageName] = defaultWindowConfig

    routes[pageName].path = page

fs.writeFileSync "#{appPath}/RN_routes.js", Template.createRoute routes


# if fs.existsSync pageFilePath + '.json'
#         outPageConfig appPath + pagePath, pageName
# outPageConfig = (path, pageName)->
#     appJson = fs.readFileSync "#{path}/#{pageName}"
#     fs.writeFileSync "#{appPath}/RN_#{pageName}_config.js", Template.createConfig appJson.toString() 







