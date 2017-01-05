//index.js
//获取应用实例
Page({
  data: {
    text: 'Hello World',
  },
  onLoad: function () {
    console.log('onLoad')
  },

  tapButton: function() {
  	console.log('tapButton');
  	wx.navigateTo({url:'/action/item/index'})
  },

  tapRequestButton: function() {
    wx.request({
      url: 'www.baidu.com'
    });
  }


})
