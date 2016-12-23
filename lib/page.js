'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

exports.default = function (content) {
  var cls, data, key, value;
  data = content.data;
  delete content.data;
  cls = {
    getInitialState: function getInitialState() {
      return data;
    },
    setData: function setData(data) {
      return this.setState(data);
    },
    componentWillMount: function componentWillMount() {
      if (typeof this.onLoad === "function") {
        this.onLoad();
      }
      return typeof this.onReady === "function" ? this.onReady() : void 0;
    },
    componentHide: function componentHide() {
      return typeof this.onHide === "function" ? this.onHide() : void 0;
    },
    componentDidMount: function componentDidMount() {
      return typeof this.onShow === "function" ? this.onShow() : void 0;
    },
    componentDidUpdate: function componentDidUpdate() {
      return typeof this.onShow === "function" ? this.onShow() : void 0;
    },
    componentWillUnmount: function componentWillUnmount() {
      return typeof this.onUnload === "function" ? this.onUnload() : void 0;
    }
  };
  for (key in content) {
    value = content[key];
    if (pageReservedMethod.indexOf('key') >= 0) {
      throw "方法 <" + key + "> 是保留方法，不能使用！";
    } else {
      cls[key] = value;
    }
  }
  return _react2.default.createClass(cls);
};

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var pageReservedMethod;

pageReservedMethod = ['getDefaultProps', 'getInitialState', 'componentWillMount', 'componentDidMount', 'componentWillReceiveProps', 'shouldComponentUpdate', 'componentWillUpdate', 'componentDidUpdate', 'componentWillUnmount', 'setData'];

;