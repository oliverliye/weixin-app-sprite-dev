// Generated by CoffeeScript 1.11.1
var Config, S, _, beautify, path, wxdbrn;

S = require('string');

_ = require('underscore');

path = require('path');

beautify = require('js-beautify').js_beautify;

wxdbrn = require('wxdatabindrn');

Config = require('../config');

module.exports = {
  createPage: function(pageCode, pageName) {
    return beautify("import " + Config.varPrefix + "wxas from 'weixin-app-sprite';\nimport " + Config.varPrefix + "provider from './RN_" + pageName + "_provider';\n\nfunction getCurrentPage() {\n    return " + Config.varPrefix + "wxas.App.getCurrentPage();\n}\n\nfunction getApp() {\n    return " + Config.varPrefix + "wxas.App.getApp();\n}\n\nvar " + Config.varPrefix + "reactClass = null;\nvar Page = function(data) {\n    data.render = function() {\n        return " + Config.varPrefix + "provider(this);\n    }\n    " + Config.varPrefix + "reactClass = " + Config.varPrefix + "wxas.Page(data);\n}\n\nwx = " + Config.varPrefix + "wxas.Wx;\n\n" + pageCode + "\n\nexport default " + Config.varPrefix + "reactClass");
  },
  createRoute: function(routes) {
    var code, content, imports, k, name, pathname, v;
    imports = [];
    code = [];
    for (name in routes) {
      content = routes[name];
      pathname = name.replace(/\/+/g, '/');
      name = name.replace(/\/+/g, '_');
      imports.push("import " + name + " from \"./" + (path.dirname(S(pathname).chompLeft('tab/').s)) + "/RN_" + (path.basename(pathname)) + "\";");
      code.push("'" + name + "': {");
      for (k in content) {
        v = content[k];
        code.push(k + ": \"" + v + "\", ");
      }
      code.push("wxas_component: " + name + ",");
      code.push("wxas_name: '" + name + "'");
      code.push("},");
    }
    code.push(" wxas_home: \"" + (_.keys(routes)[0].replace(/\/+/g, '_')) + "\" ");
    return beautify((imports.join('')) + "\n\nexport default { " + (code.join('')) + " }");
  },
  createConfig: function(code) {
    return beautify("export default " + code);
  },
  createStyle: function(wxss) {
    return beautify("import {StyleSheet} from 'react-native';\n\nexport default StyleSheet.create({" + wxss + "});");
  },
  createPageProvider: function(wxml, pageName) {
    return beautify("import " + Config.varPrefix + "React from 'react';\nimport " + Config.varPrefix + "ReactNative from 'react-native';\nimport " + Config.varPrefix + "wxssrn from 'wxssrn';\nimport " + Config.varPrefix + "rnweui from 'rnweui';\n\nimport " + Config.varPrefix + "styles from './RN_" + pageName + "_styles';\nimport " + Config.varPrefix + "class from './RN_" + pageName + "_class';\n\n" + Config.varPrefix + "component = R_$wxas$_rnweui.component\n\nexport default function(" + Config.varPrefix + "page) {\n\n    " + Config.varPrefix + "varBindArray = [];\n\n    for(" + Config.varPrefix + "key in " + Config.varPrefix + "page.state)\n\n      " + Config.varPrefix + "varBindArray.push(\"var \" + " + Config.varPrefix + "key + \"=" + Config.varPrefix + "page['\" + " + Config.varPrefix + "key + \"'];\");\n\n    eval(" + Config.varPrefix + "varBindArray.join(''));\n\n    return " + (S(wxml).replaceAll("React.createElement", Config.varPrefix + "React.createElement").s) + ";\n}");
  },
  createImportTemplate: function(data) {
    if (S(data).isEmpty()) {
      data = '';
    } else {
      data = wxdbrn.clearBindLR(data);
      data = "for(" + Config.varPrefix + "key in " + data + ") {\n    " + Config.varPrefix + "varBindArray.push(\"var \" + " + Config.varPrefix + "key + \"=" + data + "['\" + " + Config.varPrefix + "key + \"'];\");\n}\neval(" + Config.varPrefix + "varBindArray.join(''));";
    }
    return "{(function(){\n    " + data + "\n    return {{render}}\n})()}";
  },
  createLoop: function(data, item, index, children) {
    return "(function(){\n    " + Config.varPrefix + "data = " + data + "\n    " + Config.varPrefix + "result = []\n\n    for(var " + Config.varPrefix + index + " = 0; " + Config.varPrefix + index + "<" + Config.varPrefix + "data.length; " + Config.varPrefix + index + "++) {\n        var " + item + " = " + Config.varPrefix + "data[" + index + "];\n        var " + index + " = " + Config.varPrefix + index + ";\n        " + Config.varPrefix + "result.push({{render}});\n    }\n    return " + Config.varPrefix + "result;\n})()";
  },
  createTemplateProvider: function(wxml, pageName, templateName) {
    return beautify("import " + Config.varPrefix + "React from 'react';\nimport " + Config.varPrefix + "ReactNative from 'react-native';\nimport " + Config.varPrefix + "styles from './RN_" + pageName + "_" + templateName + "_styles';\nimport " + Config.varPrefix + "template from 'weixin-app-sprite';\nimport " + Config.varPrefix + "rnweui from 'rnweui';\n" + Config.varPrefix + "component = R_$wxas$_rnweui.component\n\nexport default function(" + Config.varPrefix + "bindData) {\n\n    return React.createClass({\n\n        render: function() {\n            " + Config.varPrefix + "varBindArray = [];\n\n            for(" + Config.varPrefix + "key in " + Config.varPrefix + "bindData)\n\n              " + Config.varPrefix + "varBindArray.push(\"var \" + " + Config.varPrefix + "key + \"=" + Config.varPrefix + "bindData['\" + " + Config.varPrefix + "key + \"'];\");\n\n            eval(" + Config.varPrefix + "varBindArray.join(''));\n            \n            return " + (S(wxml).replaceAll("React.createElement", Config.varPrefix + "React.createElement").s) + ";\n        }\n    });\n}");
  }
};
