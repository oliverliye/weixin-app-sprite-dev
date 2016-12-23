'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var _string = require('string');

var _string2 = _interopRequireDefault(_string);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var R_$wxas$_getViewCode, R_$wxas$_loop;

R_$wxas$_loop = function R_$wxas$_loop(data, callback) {
  var elem, i, index, len, ret;
  ret = [];
  for (index = i = 0, len = data.length; i < len; index = ++i) {
    elem = data[index];
    ret.push(callbac(elem, index));
  }
  return ret;
};

R_$wxas$_getViewCode = function R_$wxas$_getViewCode(R_$wxas$_viewData, R_$wxas$_bindData, R_$wxas$_screen, R_$wxas$_parent_size) {
  var R_$wxas$_compute_density, R_$wxas$_compute_percent, R_$wxas$_key, R_$wxas$_parent_size_array, _R_$wxas$_parse, R_$wxas$_value, R_$wxas$_varBindArray;
  R_$wxas$_varBindArray = [];
  for (R_$wxas$_key in R_$wxas$_bindData) {
    R_$wxas$_value = R_$wxas$_bindData[R_$wxas$_key];
    R_$wxas$_varBindArray.push("var " + R_$wxas$_key + "=R_$wxas$_bindData['" + R_$wxas$_value + "'];");
  }
  eval(R_$wxas$_varBindArray.join(''));
  if (R_$wxas$_parent_size) {
    R_$wxas$_parent_size_array = [R_$wxas$_parent_size];
  } else {
    R_$wxas$_parent_size_array = [{
      width: R_$wxas$_screen.width,
      height: R_$wxas$_screen.height
    }];
  }
  R_$wxas$_compute_percent = function R_$wxas$_compute_percent(parentIndex, propName, value) {
    var prop;
    prop = R_$wxas$_parent_size_array[parentIndex]['propName'];
    return prop * value;
  };
  R_$wxas$_compute_density = function R_$wxas$_compute_density(value) {
    return value / R_$wxas$_screen.density;
  };
  _R_$wxas$_parse = function R_$wxas$_parse(R_$wxas$_viewData, R_$wxas$_parent) {
    var R_$wxas$_child, R_$wxas$_ret, R_$wxas$_var, i, len, ref;
    R_$wxas$_var = {
      view: null,
      children: []
    };
    if (R_$wxas$_viewData.type === 'tag') {
      if (R_$wxas$_viewData.name === 'import') {
        return "";
      } else if (R_$wxas$_viewData.name === 'include') {
        return "";
      } else if (R_$wxas$_viewData.name === 'template') {
        return "";
      } else {
        ref = R_$wxas$_viewData.children;
        for (i = 0, len = ref.length; i < len; i++) {
          R_$wxas$_child = ref[i];
          R_$wxas$_parent_size_array.push({
            width: R_$wxas$_screen.width,
            height: R_$wxas$_screen.height
          });
          R_$wxas$_var.children.push(_R_$wxas$_parse(R_$wxas$_child, R_$wxas$_viewData));
        }
      }
      React.createElement(RN['R_$wxas$_viewData.name'], R_$wxas$_var.children);
      R_$wxas$_ret = (0, _string2.default)(R_$wxas$_viewData.template).template({
        render: "<RN." + R_$wxas$_viewData.name + " " + R_$wxas$_viewData.styleStr + " tag>" + R_$wxas$_var.children.join('') + "</RN." + R_$wxas$_viewData.name + ">"
      }).s;
    } else if (R_$wxas$_viewData.type === 'text') {
      if ((R_$wxas$_parent != null ? R_$wxas$_parent.name : void 0) === 'text') {
        R_$wxas$_ret = (0, _string2.default)(R_$wxas$_viewData.template).template({
          render: "" + R_$wxas$_parent.text
        }).s;
      } else {
        R_$wxas$_ret = (0, _string2.default)(R_$wxas$_viewData.template).template({
          render: "<RN.text>" + R_$wxas$_parent.text + "</RN.text>"
        }).s;
      }
    }
    return R_$wxas$_ret;
  };
  return _R_$wxas$_parse(R_$wxas$_viewData, null);
};

exports.default = {
  R_$wxas$_getViewCode: R_$wxas$_getViewCode
};