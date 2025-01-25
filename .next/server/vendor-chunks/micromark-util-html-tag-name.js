"use strict";
/*
 * ATTENTION: An "eval-source-map" devtool has been used.
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file with attached SourceMaps in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
exports.id = "vendor-chunks/micromark-util-html-tag-name";
exports.ids = ["vendor-chunks/micromark-util-html-tag-name"];
exports.modules = {

/***/ "(ssr)/./node_modules/micromark-util-html-tag-name/index.js":
/*!************************************************************!*\
  !*** ./node_modules/micromark-util-html-tag-name/index.js ***!
  \************************************************************/
/***/ ((__unused_webpack___webpack_module__, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   htmlBlockNames: () => (/* binding */ htmlBlockNames),\n/* harmony export */   htmlRawNames: () => (/* binding */ htmlRawNames)\n/* harmony export */ });\n/**\n * List of lowercase HTML “block” tag names.\n *\n * The list, when parsing HTML (flow), results in more relaxed rules (condition\n * 6).\n * Because they are known blocks, the HTML-like syntax doesn’t have to be\n * strictly parsed.\n * For tag names not in this list, a more strict algorithm (condition 7) is used\n * to detect whether the HTML-like syntax is seen as HTML (flow) or not.\n *\n * This is copied from:\n * <https://spec.commonmark.org/0.30/#html-blocks>.\n *\n * > 👉 **Note**: `search` was added in `CommonMark@0.31`.\n */\nconst htmlBlockNames = [\n  'address',\n  'article',\n  'aside',\n  'base',\n  'basefont',\n  'blockquote',\n  'body',\n  'caption',\n  'center',\n  'col',\n  'colgroup',\n  'dd',\n  'details',\n  'dialog',\n  'dir',\n  'div',\n  'dl',\n  'dt',\n  'fieldset',\n  'figcaption',\n  'figure',\n  'footer',\n  'form',\n  'frame',\n  'frameset',\n  'h1',\n  'h2',\n  'h3',\n  'h4',\n  'h5',\n  'h6',\n  'head',\n  'header',\n  'hr',\n  'html',\n  'iframe',\n  'legend',\n  'li',\n  'link',\n  'main',\n  'menu',\n  'menuitem',\n  'nav',\n  'noframes',\n  'ol',\n  'optgroup',\n  'option',\n  'p',\n  'param',\n  'search',\n  'section',\n  'summary',\n  'table',\n  'tbody',\n  'td',\n  'tfoot',\n  'th',\n  'thead',\n  'title',\n  'tr',\n  'track',\n  'ul'\n]\n\n/**\n * List of lowercase HTML “raw” tag names.\n *\n * The list, when parsing HTML (flow), results in HTML that can include lines\n * without exiting, until a closing tag also in this list is found (condition\n * 1).\n *\n * This module is copied from:\n * <https://spec.commonmark.org/0.30/#html-blocks>.\n *\n * > 👉 **Note**: `textarea` was added in `CommonMark@0.30`.\n */\nconst htmlRawNames = ['pre', 'script', 'style', 'textarea']\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiKHNzcikvLi9ub2RlX21vZHVsZXMvbWljcm9tYXJrLXV0aWwtaHRtbC10YWctbmFtZS9pbmRleC5qcyIsIm1hcHBpbmdzIjoiOzs7OztBQUFBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNPO0FBQ1A7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNPIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vc3Bpcml0LnlvdXJjYWlvLmNvLnVrLy4vbm9kZV9tb2R1bGVzL21pY3JvbWFyay11dGlsLWh0bWwtdGFnLW5hbWUvaW5kZXguanM/OTU2ZCJdLCJzb3VyY2VzQ29udGVudCI6WyIvKipcbiAqIExpc3Qgb2YgbG93ZXJjYXNlIEhUTUwg4oCcYmxvY2vigJ0gdGFnIG5hbWVzLlxuICpcbiAqIFRoZSBsaXN0LCB3aGVuIHBhcnNpbmcgSFRNTCAoZmxvdyksIHJlc3VsdHMgaW4gbW9yZSByZWxheGVkIHJ1bGVzIChjb25kaXRpb25cbiAqIDYpLlxuICogQmVjYXVzZSB0aGV5IGFyZSBrbm93biBibG9ja3MsIHRoZSBIVE1MLWxpa2Ugc3ludGF4IGRvZXNu4oCZdCBoYXZlIHRvIGJlXG4gKiBzdHJpY3RseSBwYXJzZWQuXG4gKiBGb3IgdGFnIG5hbWVzIG5vdCBpbiB0aGlzIGxpc3QsIGEgbW9yZSBzdHJpY3QgYWxnb3JpdGhtIChjb25kaXRpb24gNykgaXMgdXNlZFxuICogdG8gZGV0ZWN0IHdoZXRoZXIgdGhlIEhUTUwtbGlrZSBzeW50YXggaXMgc2VlbiBhcyBIVE1MIChmbG93KSBvciBub3QuXG4gKlxuICogVGhpcyBpcyBjb3BpZWQgZnJvbTpcbiAqIDxodHRwczovL3NwZWMuY29tbW9ubWFyay5vcmcvMC4zMC8jaHRtbC1ibG9ja3M+LlxuICpcbiAqID4g8J+RiSAqKk5vdGUqKjogYHNlYXJjaGAgd2FzIGFkZGVkIGluIGBDb21tb25NYXJrQDAuMzFgLlxuICovXG5leHBvcnQgY29uc3QgaHRtbEJsb2NrTmFtZXMgPSBbXG4gICdhZGRyZXNzJyxcbiAgJ2FydGljbGUnLFxuICAnYXNpZGUnLFxuICAnYmFzZScsXG4gICdiYXNlZm9udCcsXG4gICdibG9ja3F1b3RlJyxcbiAgJ2JvZHknLFxuICAnY2FwdGlvbicsXG4gICdjZW50ZXInLFxuICAnY29sJyxcbiAgJ2NvbGdyb3VwJyxcbiAgJ2RkJyxcbiAgJ2RldGFpbHMnLFxuICAnZGlhbG9nJyxcbiAgJ2RpcicsXG4gICdkaXYnLFxuICAnZGwnLFxuICAnZHQnLFxuICAnZmllbGRzZXQnLFxuICAnZmlnY2FwdGlvbicsXG4gICdmaWd1cmUnLFxuICAnZm9vdGVyJyxcbiAgJ2Zvcm0nLFxuICAnZnJhbWUnLFxuICAnZnJhbWVzZXQnLFxuICAnaDEnLFxuICAnaDInLFxuICAnaDMnLFxuICAnaDQnLFxuICAnaDUnLFxuICAnaDYnLFxuICAnaGVhZCcsXG4gICdoZWFkZXInLFxuICAnaHInLFxuICAnaHRtbCcsXG4gICdpZnJhbWUnLFxuICAnbGVnZW5kJyxcbiAgJ2xpJyxcbiAgJ2xpbmsnLFxuICAnbWFpbicsXG4gICdtZW51JyxcbiAgJ21lbnVpdGVtJyxcbiAgJ25hdicsXG4gICdub2ZyYW1lcycsXG4gICdvbCcsXG4gICdvcHRncm91cCcsXG4gICdvcHRpb24nLFxuICAncCcsXG4gICdwYXJhbScsXG4gICdzZWFyY2gnLFxuICAnc2VjdGlvbicsXG4gICdzdW1tYXJ5JyxcbiAgJ3RhYmxlJyxcbiAgJ3Rib2R5JyxcbiAgJ3RkJyxcbiAgJ3Rmb290JyxcbiAgJ3RoJyxcbiAgJ3RoZWFkJyxcbiAgJ3RpdGxlJyxcbiAgJ3RyJyxcbiAgJ3RyYWNrJyxcbiAgJ3VsJ1xuXVxuXG4vKipcbiAqIExpc3Qgb2YgbG93ZXJjYXNlIEhUTUwg4oCccmF34oCdIHRhZyBuYW1lcy5cbiAqXG4gKiBUaGUgbGlzdCwgd2hlbiBwYXJzaW5nIEhUTUwgKGZsb3cpLCByZXN1bHRzIGluIEhUTUwgdGhhdCBjYW4gaW5jbHVkZSBsaW5lc1xuICogd2l0aG91dCBleGl0aW5nLCB1bnRpbCBhIGNsb3NpbmcgdGFnIGFsc28gaW4gdGhpcyBsaXN0IGlzIGZvdW5kIChjb25kaXRpb25cbiAqIDEpLlxuICpcbiAqIFRoaXMgbW9kdWxlIGlzIGNvcGllZCBmcm9tOlxuICogPGh0dHBzOi8vc3BlYy5jb21tb25tYXJrLm9yZy8wLjMwLyNodG1sLWJsb2Nrcz4uXG4gKlxuICogPiDwn5GJICoqTm90ZSoqOiBgdGV4dGFyZWFgIHdhcyBhZGRlZCBpbiBgQ29tbW9uTWFya0AwLjMwYC5cbiAqL1xuZXhwb3J0IGNvbnN0IGh0bWxSYXdOYW1lcyA9IFsncHJlJywgJ3NjcmlwdCcsICdzdHlsZScsICd0ZXh0YXJlYSddXG4iXSwibmFtZXMiOltdLCJzb3VyY2VSb290IjoiIn0=\n//# sourceURL=webpack-internal:///(ssr)/./node_modules/micromark-util-html-tag-name/index.js\n");

/***/ })

};
;