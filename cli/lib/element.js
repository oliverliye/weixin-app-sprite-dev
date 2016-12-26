// Generated by CoffeeScript 1.12.1
var Config, Element, S, _, isEventBind, parse, parseAttr, wxdbrn;

S = require('string');

_ = require('underscore');

wxdbrn = require('wxdatabindrn');

Config = require('../config');

isEventBind = function(name) {
  return Config.bindEvents.indexOf(name) > -1;
};

Element = (function() {
  function Element(type, name1, attrs, text) {
    var attrsStr, key, value;
    this.type = type;
    this.name = name1;
    if (attrs == null) {
      attrs = {};
    }
    this.text = text != null ? text : '';
    attrs = _.extend({}, attrs);
    this.children = [];
    this.template = "{{render}}";
    this.attrs = {};
    this.attrsStr = "";
    if (attrs.hasOwnProperty('__styleindex')) {
      this.styleIndex = attrs['__styleindex'];
      delete attrs['__styleindex'];
    }
    if (attrs.hasOwnProperty('style')) {
      this.style = attrs['style'];
      delete attrs['style'];
    }
    attrsStr = [];
    for (key in attrs) {
      value = attrs[key];
      if (wxdbrn.isBind(value)) {
        attrsStr.push(key + "=" + (value = wxdbrn.convert(value)));
      } else {
        attrsStr.push(key + "='" + value + "'");
      }
      this.attrs[key] = value;
    }
    if (attrsStr.length > 0) {
      this.attrsStr = attrsStr.join(' ');
    }
  }

  Element.prototype.appendChild = function(child) {
    return this.children.push(child);
  };

  Element.prototype.toJsx = function() {
    return parse(this);
  };

  Element.prototype.toCode = function() {
    return (require("babel-core").transform(this.toJsx(), {
      plugins: ["transform-react-jsx"]
    })).code;
  };

  return Element;

})();

parseAttr = function(name, value) {
  if (wxdbrn.isBind(value)) {
    return key + "=" + (value = wxdbrn.convert(value));
  } else {
    return key + "='" + value + "'";
  }
};

parse = function(element, parent) {
  var child, children, i, len, ref, ret, style, tagName;
  children = [];
  style = [];
  if (element.hasOwnProperty('styleIndex')) {
    style.push(Config.varPrefix + "styles.style" + element.styleIndex);
  }
  if (element.hasOwnProperty('style')) {
    style.push(element['style']);
  }
  if (style.length > 0) {
    style = "style={[" + (style.join()) + "]}";
  } else {
    style = '';
  }
  if (element.type === 'tag') {
    tagName = element.name;
    ref = element.children;
    for (i = 0, len = ref.length; i < len; i++) {
      child = ref[i];
      children.push(parse(child, element));
    }
    if (element.name === 'template') {
      ret = S(element.template).template({
        render: children.join('')
      });
    } else {
      ret = S(element.template).template({
        render: "<" + Config.varPrefix + "component." + tagName + " " + element.attrsStr + " " + style + ">" + (children.join('')) + "</" + Config.varPrefix + "component." + tagName + ">"
      }).s;
    }
  } else if (element.type === 'text') {
    if ((parent != null ? parent.name : void 0) === 'text') {
      ret = S(element.template).template({
        render: "" + parent.text
      }).s;
    } else {
      ret = S(element.template).template({
        render: "<" + Config.varPrefix + "component.text " + element.attrsStr + " " + style + ">" + parent.text + "</" + Config.varPrefix + "component.text>"
      }).s;
    }
  }
  return ret;
};

module.exports = Element;
