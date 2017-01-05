S = require 'string'
_ = require 'underscore'
path = require 'path'
beautify = require('js-beautify').js_beautify
wxdbrn = require 'wxdatabindrn'

Config = require '../config'


module.exports =

    createPage: (pageCode, pageName)->
        beautify """
            import #{Config.varPrefix}wxas from 'weixin-app-sprite';
            import #{Config.varPrefix}provider from './RN_#{pageName}_provider';

            function getCurrentPage() {
                return #{Config.varPrefix}wxas.App.getCurrentPage();
            }

            function getApp() {
                return #{Config.varPrefix}wxas.App.getApp();
            }

            var #{Config.varPrefix}reactClass = null;
            var Page = function(data) {
                data.render = function() {
                    return #{Config.varPrefix}provider(this);
                }
                #{Config.varPrefix}reactClass = #{Config.varPrefix}wxas.Page(data);
            }

            wx = #{Config.varPrefix}wxas.Wx;

            #{pageCode}

            export default #{Config.varPrefix}reactClass
        """

    createRoute: (routes)->
        imports = []

        code = []

        for name, content of routes
            pathname = name.replace(/\/+/g, '/')
            name = name.replace(/\/+/g, '_')

            imports.push """import #{name} from "./#{path.dirname S(pathname).chompLeft('tab/').s}/RN_#{path.basename pathname}";"""           
            code.push "'#{name}': {"
            code.push """#{k}: "#{v}", """ for k, v of content
            code.push "wxas_component: #{name},"
            code.push "wxas_name: '#{name}'"
            code.push "},"

        code.push """ wxas_home: "#{_.keys(routes)[0].replace(/\/+/g, '_')}" """

        beautify """
            #{imports.join ''}

            export default { #{code.join ''} }
        """

    createConfig: (code)->
        beautify """
            export default #{code}
        """

    createStyle: (wxss)->
        beautify """
            import {StyleSheet} from 'react-native';

            export default StyleSheet.create({#{wxss}});
        """

    createPageProvider: (wxml, pageName)->

        beautify """
            import #{Config.varPrefix}React from 'react';
            import #{Config.varPrefix}ReactNative from 'react-native';
            import #{Config.varPrefix}wxssrn from 'wxssrn';
            import #{Config.varPrefix}rnweui from 'rnweui';

            import #{Config.varPrefix}styles from './RN_#{pageName}_styles';
            import #{Config.varPrefix}class from './RN_#{pageName}_class';

            #{Config.varPrefix}component = R_$wxas$_rnweui.component

            export default function(#{Config.varPrefix}page) {

                #{Config.varPrefix}varBindArray = [];

                for(#{Config.varPrefix}key in #{Config.varPrefix}page.state)

                  #{Config.varPrefix}varBindArray.push("var " + #{Config.varPrefix}key + "=#{Config.varPrefix}page['" + #{Config.varPrefix}key + "'];");

                eval(#{Config.varPrefix}varBindArray.join(''));

                return #{S(wxml).replaceAll("React.createElement", "#{Config.varPrefix}React.createElement").s};
            }
        """

    createImportTemplate: (data)->
        if S(data).isEmpty()
            data = ''
            
        else 
            data = wxdbrn.clearBindLR data
            data = """
                for(#{Config.varPrefix}key in #{data}) {
                    #{Config.varPrefix}varBindArray.push("var " + #{Config.varPrefix}key + "=#{data}['" + #{Config.varPrefix}key + "'];");
                }
                eval(#{Config.varPrefix}varBindArray.join(''));
            """

        """
            {(function(){
                #{data}
                return {{render}}
            })()}
        """

    createLoop: (data, item, index, children)->
        """
            (function(){
                #{Config.varPrefix}data = #{data}
                #{Config.varPrefix}result = []

                for(var #{Config.varPrefix}#{index} = 0; #{Config.varPrefix}#{index}<#{Config.varPrefix}data.length; #{Config.varPrefix}#{index}++) {
                    var #{item} = #{Config.varPrefix}data[#{index}];
                    var #{index} = #{Config.varPrefix}#{index};
                    #{Config.varPrefix}result.push({{render}});
                }
                return #{Config.varPrefix}result;
            })()
        """

    createTemplateProvider: (wxml, pageName, templateName)->

        beautify """
            import #{Config.varPrefix}React from 'react';
            import #{Config.varPrefix}ReactNative from 'react-native';
            import #{Config.varPrefix}styles from './RN_#{pageName}_#{templateName}_styles';
            import #{Config.varPrefix}template from 'weixin-app-sprite';
            import #{Config.varPrefix}rnweui from 'rnweui';
            #{Config.varPrefix}component = R_$wxas$_rnweui.component

            export default function(#{Config.varPrefix}bindData) {

                return React.createClass({

                    render: function() {
                        #{Config.varPrefix}varBindArray = [];

                        for(#{Config.varPrefix}key in #{Config.varPrefix}bindData)

                          #{Config.varPrefix}varBindArray.push("var " + #{Config.varPrefix}key + "=#{Config.varPrefix}bindData['" + #{Config.varPrefix}key + "'];");

                        eval(#{Config.varPrefix}varBindArray.join(''));
                        
                        return #{S(wxml).replaceAll("React.createElement", "#{Config.varPrefix}React.createElement").s};
                    }
                });
            }
        """
