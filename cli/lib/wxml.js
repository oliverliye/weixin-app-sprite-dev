// Generated by CoffeeScript 1.11.1
var $, Element, S, Template, Utils, Wxml, WxmlLoader, _, fs, readWxmlFile, wxdbrn;

$ = require('cheerio');

S = require('string');

_ = require('underscore');

fs = require('fs');

wxdbrn = require('wxdatabindrn');

Utils = require('./utils');

Element = require('./element');

Template = require('./template');

Wxml = (function() {
  function Wxml(basePath, $root) {
    this.basePath = basePath;
    this.$root = $root;
  }

  Wxml.prototype.convertNode = function($dom) {
    var $child, child, condition, element, hasChildren, hidden, i, ifs, index, isTextNode, item, j, k, len1, len2, len3, nodes, ref, ref1, template, templateFor, wxelif, wxfor, wxif;
    if (Utils.isInvalidNode($dom)) {
      return null;
    }
    $dom.removeAttr('wx:key');
    isTextNode = Utils.isTextNode($dom);
    hasChildren = ((ref = $dom[0].children) != null ? ref.length : void 0) > 0;
    if ($dom[0].type === 'root') {
      element = new Element('tag', 'view', {});
    } else if ($dom[0].name === 'template') {
      element = new Element('tag', 'template', {});
      element.template = Template.createImportTemplate($dom.attr('data'));
    } else {
      element = new Element($dom[0].type, $dom[0].name, $dom.attr(), wxdbrn.chompBindLR($dom.text()));
    }
    if (hasChildren) {
      nodes = Utils.filterInvalidNode($dom[0].children);
      if (nodes.length > 0) {
        ifs = [];
        ref1 = $dom[0].children;
        for (i = 0, len1 = ref1.length; i < len1; i++) {
          child = ref1[i];
          $child = $(child);
          $child.removeAttr('wx:key');
          if (Utils.isInvalidNode($child)) {
            continue;
          }
          template = null;
          templateFor = null;
          if (!S(wxfor = $child.attr('wx:for')).isEmpty()) {
            item = S($child.attr('wx:for-item')).isEmpty() ? 'item' : $child.attr('wx:for-item');
            index = S($child.attr('wx:for-index')).isEmpty() ? 'index' : $child.attr('wx:for-index');
            templateFor = Template.createLoop(wxdbrn.clearBindLR(wxfor), item, index);
            $child.removeAttr('wx:for');
            $child.removeAttr('wx:for-item');
            $child.removeAttr('wx:for-index');
          }
          if (_.isString(hidden = $child.attr('hidden'))) {
            if (wxdbrn.isBind(hidden)) {
              hidden = wxdbrn.clearBindLR(hidden);
            } else {
              hidden = true;
            }
            $child.removeAttr('hidden');
            template = "{ " + hidden + " ? {{render}} : null }";
          } else if (!S(wxif = $child.attr('wx:if')).isEmpty()) {
            if (wxdbrn.isBind(wxif)) {
              wxif = wxdbrn.clearBindLR(wxif);
            } else {
              wxif = true;
            }
            ifs.push(wxif);
            template = "{ " + wxif + " ? ({{render}}) : null }";
            $child.removeAttr('wx:if');
          } else if (!S(wxelif = $child.attr('wx:elif')).isEmpty()) {
            if (wxdbrn.isBind(wxelif)) {
              wxelif = wxdbrn.clearBindLR(wxelif);
            } else {
              wxelif = true;
            }
            condition = "";
            for (j = 0, len2 = ifs.length; j < len2; j++) {
              wxif = ifs[j];
              condition += "!(" + wxif + ") && ";
            }
            template = "{ " + condition + " " + wxelif + " ? {{render}} : null }";
            ifs.push(wxelif);
            $child.removeAttr('wx:elif');
          } else if ($child.attr('wx:else') === '') {
            condition = "";
            for (k = 0, len3 = ifs.length; k < len3; k++) {
              wxif = ifs[k];
              condition += "!(" + wxif + ") && ";
            }
            template = "{ " + condition + " true ? {{render}} : null }";
            $child.removeAttr('wx:else');
          }
          item = this.convertNode($(child));
          if (!template && templateFor) {
            template = "{" + templateFor + "}";
          } else if (template && templateFor) {
            template = S(template).template({
              render: templateFor
            }).s;
          }
          if (template) {
            item.template = template;
          }
          element.appendChild(item);
        }
      }
    }
    return element;
  };

  Wxml.prototype.parse = function() {
    return this.convertNode(this.$root);
  };

  return Wxml;

})();

WxmlLoader = (function() {
  function WxmlLoader(path1, pageName) {
    var $importTemplate, $template, child, i, importTemplate, j, k, len1, len2, len3, ref, ref1, ref2, ref3, src, template;
    this.path = path1;
    this.templates = {};
    this.imports = {};
    this.importsSrc = [];
    this.importsArray = [];
    this.$wxml = $.load((fs.readFileSync(this.path + "/" + pageName)).toString(), {
      recognizeSelfClosing: true,
      normalizeWhitespace: true
    });
    ref = this.$wxml.root().find('template[name]');
    for (i = 0, len1 = ref.length; i < len1; i++) {
      template = ref[i];
      $template = $(template);
      if (((ref1 = $template[0].children) != null ? ref1.length : void 0) > 0) {
        ref2 = $template[0].children;
        for (j = 0, len2 = ref2.length; j < len2; j++) {
          child = ref2[j];
          $(child).insertBefore($template);
        }
      }
      this.templates[$template.attr('name')] = $template;
      $template.remove();
    }
    ref3 = this.$wxml.root().find('import[src]');
    for (k = 0, len3 = ref3.length; k < len3; k++) {
      importTemplate = ref3[k];
      $importTemplate = $(importTemplate);
      src = $importTemplate.attr('src');
      this.imports[src] = (readWxmlFile(this.path, src)).templates;
      this.importsArray.push(this.imports[src]);
    }
  }

  WxmlLoader.prototype.load = function() {
    this._pretreatment(this.path, this.$wxml.root());
    return {
      $wxml: this.$wxml.root(),
      templates: this.templates
    };
  };


  /*
      预处理wxml
      1.将未包含在标签里的文字结点，外面包一层text标签
      2.将include的wxml替换为当前结点
   */

  WxmlLoader.prototype._pretreatment = function(path, $node) {
    var $template, child, data, i, len, len1, name, node, ref, ref1, ref2, src;
    if (!(node = $node[0])) {
      return;
    }
    if (node.type === 'text' && !(((ref = $node.parent()[0]) != null ? ref.name : void 0) === 'text') && !Utils.isEmptyTextNode(node)) {
      $node.wrap($('<text>'));
    } else if (Utils.isIncludeNode(node)) {
      $node.replaceWith(readWxmlFile(path, $node.attr('src')).$wxml.children()).remove();
      return;
    } else if (Utils.isImportNode(node)) {
      this.importsSrc.push($node.attr('src'));
      $node.remove();
      return;
    } else if (Utils.isTemplateNode(node)) {
      name = $node.attr('is');
      data = $node.attr('data');
      if (!data) {
        data = '';
      }
      if (_.has(this.templates, name)) {
        $node.replaceWith(this.templates[name].clone().attr({
          name: name,
          is: $node.attr('is'),
          data: data
        }));
      } else if (_.size(this.importsSrc) > 0) {
        src = _.last(this.importsSrc);
        if (_.has(this.imports, src) && _.has(this.imports[src], name)) {
          $template = this.imports[src][name];
          $node.replaceWith($template.clone().attr({
            name: src,
            is: $node.attr('is'),
            data: data
          }));
        }
      }
      return;
    } else if (((ref1 = node.children) != null ? ref1.length : void 0) > 0) {
      len = this.importsSrc.length;
      ref2 = node.children;
      for (i = 0, len1 = ref2.length; i < len1; i++) {
        child = ref2[i];
        this._pretreatment(path, $(child));
      }
      if (this.importsSrc.length > len) {
        this.importsSrc = this.importsSrc.slice(0, len - 1);
      }
    }
  };

  return WxmlLoader;

})();

readWxmlFile = function(path, pageName) {
  var wp;
  wp = new WxmlLoader(path, pageName);
  return wp.load();
};

module.exports = function(path, pageName, wxss) {
  var $wxml, element, pageProvider, ref, templates;
  if (wxss == null) {
    wxss = null;
  }
  ref = readWxmlFile(path, pageName + '.wxml'), $wxml = ref.$wxml, templates = ref.templates;
  if (wxss != null) {
    wxss.setToWxml($wxml);
  }
  element = (new Wxml(path, $wxml)).parse();
  pageProvider = Template.createPageProvider(element.toCode(), pageName);
  fs.writeFileSync(path + "/RN_" + pageName + "_provider.js", pageProvider);
  fs.writeFileSync(path + "/RN_" + pageName + "_styles.js", Template.createStyle(wxss ? wxss.toStyleCode() : ''));
  return fs.writeFileSync(path + "/RN_" + pageName + "_class.js", Template.createStyle(wxss ? wxss.toClassCode() : ''));
};
