"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = {
  loop: function loop(data, callback) {
    var i, index, item, len, results;
    results = [];
    for (index = i = 0, len = data.length; i < len; index = ++i) {
      item = data[index];
      results.push(callback(item, index));
    }
    return results;
  }
};