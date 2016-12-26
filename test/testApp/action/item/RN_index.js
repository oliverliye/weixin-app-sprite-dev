import R_$wxas$_wxas from 'weixin-app-sprite';
import R_$wxas$_provider from './RN_index_provider';

function getCurrentPage() {
    return R_$wxas$_wxas.App.getCurrentPage();
}

function getApp() {
    return R_$wxas$_wxas.App.getApp();
}

var R_$wxas$_reactClass = null;
var Page = function(data) {
    data.render = function() {
        return R_$wxas$_provider(this);
    }
    R_$wxas$_reactClass = R_$wxas$_wxas.Page(data);
}

wx = R_$wxas$_wxas.wx;

//index.js
//获取应用实例
Page({
    data: {
        text: 'Hello World',
    },
    onLoad: function() {
        console.log('onLoad')
    }
})


export default R_$wxas$_reactClass