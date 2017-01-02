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
  	wx.navigateBack()
  },

  redirectButton: function() {
  	console.log('tapButton');
  	wx.redirectTo({url:'pages_index_index'});
  }

  
})
