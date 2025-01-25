"use strict";
/*
 * ATTENTION: An "eval-source-map" devtool has been used.
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file with attached SourceMaps in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
exports.id = "vendor-chunks/micromark-extension-gfm-tagfilter";
exports.ids = ["vendor-chunks/micromark-extension-gfm-tagfilter"];
exports.modules = {

/***/ "(ssr)/./node_modules/micromark-extension-gfm-tagfilter/lib/index.js":
/*!*********************************************************************!*\
  !*** ./node_modules/micromark-extension-gfm-tagfilter/lib/index.js ***!
  \*********************************************************************/
/***/ ((__unused_webpack___webpack_module__, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   gfmTagfilterHtml: () => (/* binding */ gfmTagfilterHtml)\n/* harmony export */ });\n/**\n * @typedef {import('micromark-util-types').CompileContext} CompileContext\n * @typedef {import('micromark-util-types').HtmlExtension} HtmlExtension\n * @typedef {import('micromark-util-types').Token} Token\n */\n\n// An opening or closing tag start, followed by a case-insensitive specific tag name,\n// followed by HTML whitespace, a greater than, or a slash.\nconst reFlow =\n  /<(\\/?)(iframe|noembed|noframes|plaintext|script|style|title|textarea|xmp)(?=[\\t\\n\\f\\r />])/gi\n\n// As HTML (text) parses tags separately (and very strictly), we don’t need to be\n// global.\nconst reText = new RegExp('^' + reFlow.source, 'i')\n\n/**\n * Create an HTML extension for `micromark` to support GitHubs weird and\n * useless tagfilter when serializing to HTML.\n *\n * @returns {HtmlExtension}\n *   Extension for `micromark` that can be passed in `htmlExtensions` to support\n *   GitHubs weird and useless tagfilter when serializing to HTML.\n */\nfunction gfmTagfilterHtml() {\n  return {\n    exit: {\n      htmlFlowData(token) {\n        exitHtmlData.call(this, token, reFlow)\n      },\n      htmlTextData(token) {\n        exitHtmlData.call(this, token, reText)\n      }\n    }\n  }\n}\n\n/**\n * @this {CompileContext}\n * @param {Token} token\n * @param {RegExp} filter\n * @returns {undefined}\n */\nfunction exitHtmlData(token, filter) {\n  let value = this.sliceSerialize(token)\n\n  if (this.options.allowDangerousHtml) {\n    value = value.replace(filter, '&lt;$1$2')\n  }\n\n  this.raw(this.encode(value))\n}\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiKHNzcikvLi9ub2RlX21vZHVsZXMvbWljcm9tYXJrLWV4dGVuc2lvbi1nZm0tdGFnZmlsdGVyL2xpYi9pbmRleC5qcyIsIm1hcHBpbmdzIjoiOzs7O0FBQUE7QUFDQSxhQUFhLCtDQUErQztBQUM1RCxhQUFhLDhDQUE4QztBQUMzRCxhQUFhLHNDQUFzQztBQUNuRDs7QUFFQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQSxhQUFhO0FBQ2I7QUFDQTtBQUNBO0FBQ087QUFDUDtBQUNBO0FBQ0E7QUFDQTtBQUNBLE9BQU87QUFDUDtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQSxVQUFVO0FBQ1YsV0FBVyxPQUFPO0FBQ2xCLFdBQVcsUUFBUTtBQUNuQixhQUFhO0FBQ2I7QUFDQTtBQUNBOztBQUVBO0FBQ0EsdUNBQXVDO0FBQ3ZDOztBQUVBO0FBQ0EiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9zcGlyaXQueW91cmNhaW8uY28udWsvLi9ub2RlX21vZHVsZXMvbWljcm9tYXJrLWV4dGVuc2lvbi1nZm0tdGFnZmlsdGVyL2xpYi9pbmRleC5qcz8zNDdkIl0sInNvdXJjZXNDb250ZW50IjpbIi8qKlxuICogQHR5cGVkZWYge2ltcG9ydCgnbWljcm9tYXJrLXV0aWwtdHlwZXMnKS5Db21waWxlQ29udGV4dH0gQ29tcGlsZUNvbnRleHRcbiAqIEB0eXBlZGVmIHtpbXBvcnQoJ21pY3JvbWFyay11dGlsLXR5cGVzJykuSHRtbEV4dGVuc2lvbn0gSHRtbEV4dGVuc2lvblxuICogQHR5cGVkZWYge2ltcG9ydCgnbWljcm9tYXJrLXV0aWwtdHlwZXMnKS5Ub2tlbn0gVG9rZW5cbiAqL1xuXG4vLyBBbiBvcGVuaW5nIG9yIGNsb3NpbmcgdGFnIHN0YXJ0LCBmb2xsb3dlZCBieSBhIGNhc2UtaW5zZW5zaXRpdmUgc3BlY2lmaWMgdGFnIG5hbWUsXG4vLyBmb2xsb3dlZCBieSBIVE1MIHdoaXRlc3BhY2UsIGEgZ3JlYXRlciB0aGFuLCBvciBhIHNsYXNoLlxuY29uc3QgcmVGbG93ID1cbiAgLzwoXFwvPykoaWZyYW1lfG5vZW1iZWR8bm9mcmFtZXN8cGxhaW50ZXh0fHNjcmlwdHxzdHlsZXx0aXRsZXx0ZXh0YXJlYXx4bXApKD89W1xcdFxcblxcZlxcciAvPl0pL2dpXG5cbi8vIEFzIEhUTUwgKHRleHQpIHBhcnNlcyB0YWdzIHNlcGFyYXRlbHkgKGFuZCB2ZXJ5IHN0cmljdGx5KSwgd2UgZG9u4oCZdCBuZWVkIHRvIGJlXG4vLyBnbG9iYWwuXG5jb25zdCByZVRleHQgPSBuZXcgUmVnRXhwKCdeJyArIHJlRmxvdy5zb3VyY2UsICdpJylcblxuLyoqXG4gKiBDcmVhdGUgYW4gSFRNTCBleHRlbnNpb24gZm9yIGBtaWNyb21hcmtgIHRvIHN1cHBvcnQgR2l0SHVicyB3ZWlyZCBhbmRcbiAqIHVzZWxlc3MgdGFnZmlsdGVyIHdoZW4gc2VyaWFsaXppbmcgdG8gSFRNTC5cbiAqXG4gKiBAcmV0dXJucyB7SHRtbEV4dGVuc2lvbn1cbiAqICAgRXh0ZW5zaW9uIGZvciBgbWljcm9tYXJrYCB0aGF0IGNhbiBiZSBwYXNzZWQgaW4gYGh0bWxFeHRlbnNpb25zYCB0byBzdXBwb3J0XG4gKiAgIEdpdEh1YnMgd2VpcmQgYW5kIHVzZWxlc3MgdGFnZmlsdGVyIHdoZW4gc2VyaWFsaXppbmcgdG8gSFRNTC5cbiAqL1xuZXhwb3J0IGZ1bmN0aW9uIGdmbVRhZ2ZpbHRlckh0bWwoKSB7XG4gIHJldHVybiB7XG4gICAgZXhpdDoge1xuICAgICAgaHRtbEZsb3dEYXRhKHRva2VuKSB7XG4gICAgICAgIGV4aXRIdG1sRGF0YS5jYWxsKHRoaXMsIHRva2VuLCByZUZsb3cpXG4gICAgICB9LFxuICAgICAgaHRtbFRleHREYXRhKHRva2VuKSB7XG4gICAgICAgIGV4aXRIdG1sRGF0YS5jYWxsKHRoaXMsIHRva2VuLCByZVRleHQpXG4gICAgICB9XG4gICAgfVxuICB9XG59XG5cbi8qKlxuICogQHRoaXMge0NvbXBpbGVDb250ZXh0fVxuICogQHBhcmFtIHtUb2tlbn0gdG9rZW5cbiAqIEBwYXJhbSB7UmVnRXhwfSBmaWx0ZXJcbiAqIEByZXR1cm5zIHt1bmRlZmluZWR9XG4gKi9cbmZ1bmN0aW9uIGV4aXRIdG1sRGF0YSh0b2tlbiwgZmlsdGVyKSB7XG4gIGxldCB2YWx1ZSA9IHRoaXMuc2xpY2VTZXJpYWxpemUodG9rZW4pXG5cbiAgaWYgKHRoaXMub3B0aW9ucy5hbGxvd0Rhbmdlcm91c0h0bWwpIHtcbiAgICB2YWx1ZSA9IHZhbHVlLnJlcGxhY2UoZmlsdGVyLCAnJmx0OyQxJDInKVxuICB9XG5cbiAgdGhpcy5yYXcodGhpcy5lbmNvZGUodmFsdWUpKVxufVxuIl0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///(ssr)/./node_modules/micromark-extension-gfm-tagfilter/lib/index.js\n");

/***/ })

};
;