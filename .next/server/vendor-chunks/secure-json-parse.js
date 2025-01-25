"use strict";
/*
 * ATTENTION: An "eval-source-map" devtool has been used.
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file with attached SourceMaps in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
exports.id = "vendor-chunks/secure-json-parse";
exports.ids = ["vendor-chunks/secure-json-parse"];
exports.modules = {

/***/ "(ssr)/./node_modules/secure-json-parse/index.js":
/*!*************************************************!*\
  !*** ./node_modules/secure-json-parse/index.js ***!
  \*************************************************/
/***/ ((module) => {

eval("\n\nconst hasBuffer = typeof Buffer !== 'undefined'\nconst suspectProtoRx = /\"(?:_|\\\\u005[Ff])(?:_|\\\\u005[Ff])(?:p|\\\\u0070)(?:r|\\\\u0072)(?:o|\\\\u006[Ff])(?:t|\\\\u0074)(?:o|\\\\u006[Ff])(?:_|\\\\u005[Ff])(?:_|\\\\u005[Ff])\"\\s*:/\nconst suspectConstructorRx = /\"(?:c|\\\\u0063)(?:o|\\\\u006[Ff])(?:n|\\\\u006[Ee])(?:s|\\\\u0073)(?:t|\\\\u0074)(?:r|\\\\u0072)(?:u|\\\\u0075)(?:c|\\\\u0063)(?:t|\\\\u0074)(?:o|\\\\u006[Ff])(?:r|\\\\u0072)\"\\s*:/\n\nfunction _parse (text, reviver, options) {\n  // Normalize arguments\n  if (options == null) {\n    if (reviver !== null && typeof reviver === 'object') {\n      options = reviver\n      reviver = undefined\n    }\n  }\n\n  if (hasBuffer && Buffer.isBuffer(text)) {\n    text = text.toString()\n  }\n\n  // BOM checker\n  if (text && text.charCodeAt(0) === 0xFEFF) {\n    text = text.slice(1)\n  }\n\n  // Parse normally, allowing exceptions\n  const obj = JSON.parse(text, reviver)\n\n  // Ignore null and non-objects\n  if (obj === null || typeof obj !== 'object') {\n    return obj\n  }\n\n  const protoAction = (options && options.protoAction) || 'error'\n  const constructorAction = (options && options.constructorAction) || 'error'\n\n  // options: 'error' (default) / 'remove' / 'ignore'\n  if (protoAction === 'ignore' && constructorAction === 'ignore') {\n    return obj\n  }\n\n  if (protoAction !== 'ignore' && constructorAction !== 'ignore') {\n    if (suspectProtoRx.test(text) === false && suspectConstructorRx.test(text) === false) {\n      return obj\n    }\n  } else if (protoAction !== 'ignore' && constructorAction === 'ignore') {\n    if (suspectProtoRx.test(text) === false) {\n      return obj\n    }\n  } else {\n    if (suspectConstructorRx.test(text) === false) {\n      return obj\n    }\n  }\n\n  // Scan result for proto keys\n  return filter(obj, { protoAction, constructorAction, safe: options && options.safe })\n}\n\nfunction filter (obj, { protoAction = 'error', constructorAction = 'error', safe } = {}) {\n  let next = [obj]\n\n  while (next.length) {\n    const nodes = next\n    next = []\n\n    for (const node of nodes) {\n      if (protoAction !== 'ignore' && Object.prototype.hasOwnProperty.call(node, '__proto__')) { // Avoid calling node.hasOwnProperty directly\n        if (safe === true) {\n          return null\n        } else if (protoAction === 'error') {\n          throw new SyntaxError('Object contains forbidden prototype property')\n        }\n\n        delete node.__proto__ // eslint-disable-line no-proto\n      }\n\n      if (constructorAction !== 'ignore' &&\n          Object.prototype.hasOwnProperty.call(node, 'constructor') &&\n          Object.prototype.hasOwnProperty.call(node.constructor, 'prototype')) { // Avoid calling node.hasOwnProperty directly\n        if (safe === true) {\n          return null\n        } else if (constructorAction === 'error') {\n          throw new SyntaxError('Object contains forbidden prototype property')\n        }\n\n        delete node.constructor\n      }\n\n      for (const key in node) {\n        const value = node[key]\n        if (value && typeof value === 'object') {\n          next.push(value)\n        }\n      }\n    }\n  }\n  return obj\n}\n\nfunction parse (text, reviver, options) {\n  const stackTraceLimit = Error.stackTraceLimit\n  Error.stackTraceLimit = 0\n  try {\n    return _parse(text, reviver, options)\n  } finally {\n    Error.stackTraceLimit = stackTraceLimit\n  }\n}\n\nfunction safeParse (text, reviver) {\n  const stackTraceLimit = Error.stackTraceLimit\n  Error.stackTraceLimit = 0\n  try {\n    return _parse(text, reviver, { safe: true })\n  } catch (_e) {\n    return null\n  } finally {\n    Error.stackTraceLimit = stackTraceLimit\n  }\n}\n\nmodule.exports = parse\nmodule.exports[\"default\"] = parse\nmodule.exports.parse = parse\nmodule.exports.safeParse = safeParse\nmodule.exports.scan = filter\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiKHNzcikvLi9ub2RlX21vZHVsZXMvc2VjdXJlLWpzb24tcGFyc2UvaW5kZXguanMiLCJtYXBwaW5ncyI6IkFBQVk7O0FBRVo7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLElBQUk7QUFDSjtBQUNBO0FBQ0E7QUFDQSxJQUFJO0FBQ0o7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQSx1QkFBdUIsK0RBQStEO0FBQ3RGOztBQUVBLHdCQUF3QiwyREFBMkQsSUFBSTtBQUN2Rjs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQSxpR0FBaUc7QUFDakc7QUFDQTtBQUNBLFVBQVU7QUFDVjtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBLGlGQUFpRjtBQUNqRjtBQUNBO0FBQ0EsVUFBVTtBQUNWO0FBQ0E7O0FBRUE7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsSUFBSTtBQUNKO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLG1DQUFtQyxZQUFZO0FBQy9DLElBQUk7QUFDSjtBQUNBLElBQUk7QUFDSjtBQUNBO0FBQ0E7O0FBRUE7QUFDQSx5QkFBc0I7QUFDdEIsb0JBQW9CO0FBQ3BCLHdCQUF3QjtBQUN4QixtQkFBbUIiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9zcGlyaXQueW91cmNhaW8uY28udWsvLi9ub2RlX21vZHVsZXMvc2VjdXJlLWpzb24tcGFyc2UvaW5kZXguanM/MzAzNyJdLCJzb3VyY2VzQ29udGVudCI6WyIndXNlIHN0cmljdCdcblxuY29uc3QgaGFzQnVmZmVyID0gdHlwZW9mIEJ1ZmZlciAhPT0gJ3VuZGVmaW5lZCdcbmNvbnN0IHN1c3BlY3RQcm90b1J4ID0gL1wiKD86X3xcXFxcdTAwNVtGZl0pKD86X3xcXFxcdTAwNVtGZl0pKD86cHxcXFxcdTAwNzApKD86cnxcXFxcdTAwNzIpKD86b3xcXFxcdTAwNltGZl0pKD86dHxcXFxcdTAwNzQpKD86b3xcXFxcdTAwNltGZl0pKD86X3xcXFxcdTAwNVtGZl0pKD86X3xcXFxcdTAwNVtGZl0pXCJcXHMqOi9cbmNvbnN0IHN1c3BlY3RDb25zdHJ1Y3RvclJ4ID0gL1wiKD86Y3xcXFxcdTAwNjMpKD86b3xcXFxcdTAwNltGZl0pKD86bnxcXFxcdTAwNltFZV0pKD86c3xcXFxcdTAwNzMpKD86dHxcXFxcdTAwNzQpKD86cnxcXFxcdTAwNzIpKD86dXxcXFxcdTAwNzUpKD86Y3xcXFxcdTAwNjMpKD86dHxcXFxcdTAwNzQpKD86b3xcXFxcdTAwNltGZl0pKD86cnxcXFxcdTAwNzIpXCJcXHMqOi9cblxuZnVuY3Rpb24gX3BhcnNlICh0ZXh0LCByZXZpdmVyLCBvcHRpb25zKSB7XG4gIC8vIE5vcm1hbGl6ZSBhcmd1bWVudHNcbiAgaWYgKG9wdGlvbnMgPT0gbnVsbCkge1xuICAgIGlmIChyZXZpdmVyICE9PSBudWxsICYmIHR5cGVvZiByZXZpdmVyID09PSAnb2JqZWN0Jykge1xuICAgICAgb3B0aW9ucyA9IHJldml2ZXJcbiAgICAgIHJldml2ZXIgPSB1bmRlZmluZWRcbiAgICB9XG4gIH1cblxuICBpZiAoaGFzQnVmZmVyICYmIEJ1ZmZlci5pc0J1ZmZlcih0ZXh0KSkge1xuICAgIHRleHQgPSB0ZXh0LnRvU3RyaW5nKClcbiAgfVxuXG4gIC8vIEJPTSBjaGVja2VyXG4gIGlmICh0ZXh0ICYmIHRleHQuY2hhckNvZGVBdCgwKSA9PT0gMHhGRUZGKSB7XG4gICAgdGV4dCA9IHRleHQuc2xpY2UoMSlcbiAgfVxuXG4gIC8vIFBhcnNlIG5vcm1hbGx5LCBhbGxvd2luZyBleGNlcHRpb25zXG4gIGNvbnN0IG9iaiA9IEpTT04ucGFyc2UodGV4dCwgcmV2aXZlcilcblxuICAvLyBJZ25vcmUgbnVsbCBhbmQgbm9uLW9iamVjdHNcbiAgaWYgKG9iaiA9PT0gbnVsbCB8fCB0eXBlb2Ygb2JqICE9PSAnb2JqZWN0Jykge1xuICAgIHJldHVybiBvYmpcbiAgfVxuXG4gIGNvbnN0IHByb3RvQWN0aW9uID0gKG9wdGlvbnMgJiYgb3B0aW9ucy5wcm90b0FjdGlvbikgfHwgJ2Vycm9yJ1xuICBjb25zdCBjb25zdHJ1Y3RvckFjdGlvbiA9IChvcHRpb25zICYmIG9wdGlvbnMuY29uc3RydWN0b3JBY3Rpb24pIHx8ICdlcnJvcidcblxuICAvLyBvcHRpb25zOiAnZXJyb3InIChkZWZhdWx0KSAvICdyZW1vdmUnIC8gJ2lnbm9yZSdcbiAgaWYgKHByb3RvQWN0aW9uID09PSAnaWdub3JlJyAmJiBjb25zdHJ1Y3RvckFjdGlvbiA9PT0gJ2lnbm9yZScpIHtcbiAgICByZXR1cm4gb2JqXG4gIH1cblxuICBpZiAocHJvdG9BY3Rpb24gIT09ICdpZ25vcmUnICYmIGNvbnN0cnVjdG9yQWN0aW9uICE9PSAnaWdub3JlJykge1xuICAgIGlmIChzdXNwZWN0UHJvdG9SeC50ZXN0KHRleHQpID09PSBmYWxzZSAmJiBzdXNwZWN0Q29uc3RydWN0b3JSeC50ZXN0KHRleHQpID09PSBmYWxzZSkge1xuICAgICAgcmV0dXJuIG9ialxuICAgIH1cbiAgfSBlbHNlIGlmIChwcm90b0FjdGlvbiAhPT0gJ2lnbm9yZScgJiYgY29uc3RydWN0b3JBY3Rpb24gPT09ICdpZ25vcmUnKSB7XG4gICAgaWYgKHN1c3BlY3RQcm90b1J4LnRlc3QodGV4dCkgPT09IGZhbHNlKSB7XG4gICAgICByZXR1cm4gb2JqXG4gICAgfVxuICB9IGVsc2Uge1xuICAgIGlmIChzdXNwZWN0Q29uc3RydWN0b3JSeC50ZXN0KHRleHQpID09PSBmYWxzZSkge1xuICAgICAgcmV0dXJuIG9ialxuICAgIH1cbiAgfVxuXG4gIC8vIFNjYW4gcmVzdWx0IGZvciBwcm90byBrZXlzXG4gIHJldHVybiBmaWx0ZXIob2JqLCB7IHByb3RvQWN0aW9uLCBjb25zdHJ1Y3RvckFjdGlvbiwgc2FmZTogb3B0aW9ucyAmJiBvcHRpb25zLnNhZmUgfSlcbn1cblxuZnVuY3Rpb24gZmlsdGVyIChvYmosIHsgcHJvdG9BY3Rpb24gPSAnZXJyb3InLCBjb25zdHJ1Y3RvckFjdGlvbiA9ICdlcnJvcicsIHNhZmUgfSA9IHt9KSB7XG4gIGxldCBuZXh0ID0gW29ial1cblxuICB3aGlsZSAobmV4dC5sZW5ndGgpIHtcbiAgICBjb25zdCBub2RlcyA9IG5leHRcbiAgICBuZXh0ID0gW11cblxuICAgIGZvciAoY29uc3Qgbm9kZSBvZiBub2Rlcykge1xuICAgICAgaWYgKHByb3RvQWN0aW9uICE9PSAnaWdub3JlJyAmJiBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwobm9kZSwgJ19fcHJvdG9fXycpKSB7IC8vIEF2b2lkIGNhbGxpbmcgbm9kZS5oYXNPd25Qcm9wZXJ0eSBkaXJlY3RseVxuICAgICAgICBpZiAoc2FmZSA9PT0gdHJ1ZSkge1xuICAgICAgICAgIHJldHVybiBudWxsXG4gICAgICAgIH0gZWxzZSBpZiAocHJvdG9BY3Rpb24gPT09ICdlcnJvcicpIHtcbiAgICAgICAgICB0aHJvdyBuZXcgU3ludGF4RXJyb3IoJ09iamVjdCBjb250YWlucyBmb3JiaWRkZW4gcHJvdG90eXBlIHByb3BlcnR5JylcbiAgICAgICAgfVxuXG4gICAgICAgIGRlbGV0ZSBub2RlLl9fcHJvdG9fXyAvLyBlc2xpbnQtZGlzYWJsZS1saW5lIG5vLXByb3RvXG4gICAgICB9XG5cbiAgICAgIGlmIChjb25zdHJ1Y3RvckFjdGlvbiAhPT0gJ2lnbm9yZScgJiZcbiAgICAgICAgICBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwobm9kZSwgJ2NvbnN0cnVjdG9yJykgJiZcbiAgICAgICAgICBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwobm9kZS5jb25zdHJ1Y3RvciwgJ3Byb3RvdHlwZScpKSB7IC8vIEF2b2lkIGNhbGxpbmcgbm9kZS5oYXNPd25Qcm9wZXJ0eSBkaXJlY3RseVxuICAgICAgICBpZiAoc2FmZSA9PT0gdHJ1ZSkge1xuICAgICAgICAgIHJldHVybiBudWxsXG4gICAgICAgIH0gZWxzZSBpZiAoY29uc3RydWN0b3JBY3Rpb24gPT09ICdlcnJvcicpIHtcbiAgICAgICAgICB0aHJvdyBuZXcgU3ludGF4RXJyb3IoJ09iamVjdCBjb250YWlucyBmb3JiaWRkZW4gcHJvdG90eXBlIHByb3BlcnR5JylcbiAgICAgICAgfVxuXG4gICAgICAgIGRlbGV0ZSBub2RlLmNvbnN0cnVjdG9yXG4gICAgICB9XG5cbiAgICAgIGZvciAoY29uc3Qga2V5IGluIG5vZGUpIHtcbiAgICAgICAgY29uc3QgdmFsdWUgPSBub2RlW2tleV1cbiAgICAgICAgaWYgKHZhbHVlICYmIHR5cGVvZiB2YWx1ZSA9PT0gJ29iamVjdCcpIHtcbiAgICAgICAgICBuZXh0LnB1c2godmFsdWUpXG4gICAgICAgIH1cbiAgICAgIH1cbiAgICB9XG4gIH1cbiAgcmV0dXJuIG9ialxufVxuXG5mdW5jdGlvbiBwYXJzZSAodGV4dCwgcmV2aXZlciwgb3B0aW9ucykge1xuICBjb25zdCBzdGFja1RyYWNlTGltaXQgPSBFcnJvci5zdGFja1RyYWNlTGltaXRcbiAgRXJyb3Iuc3RhY2tUcmFjZUxpbWl0ID0gMFxuICB0cnkge1xuICAgIHJldHVybiBfcGFyc2UodGV4dCwgcmV2aXZlciwgb3B0aW9ucylcbiAgfSBmaW5hbGx5IHtcbiAgICBFcnJvci5zdGFja1RyYWNlTGltaXQgPSBzdGFja1RyYWNlTGltaXRcbiAgfVxufVxuXG5mdW5jdGlvbiBzYWZlUGFyc2UgKHRleHQsIHJldml2ZXIpIHtcbiAgY29uc3Qgc3RhY2tUcmFjZUxpbWl0ID0gRXJyb3Iuc3RhY2tUcmFjZUxpbWl0XG4gIEVycm9yLnN0YWNrVHJhY2VMaW1pdCA9IDBcbiAgdHJ5IHtcbiAgICByZXR1cm4gX3BhcnNlKHRleHQsIHJldml2ZXIsIHsgc2FmZTogdHJ1ZSB9KVxuICB9IGNhdGNoIChfZSkge1xuICAgIHJldHVybiBudWxsXG4gIH0gZmluYWxseSB7XG4gICAgRXJyb3Iuc3RhY2tUcmFjZUxpbWl0ID0gc3RhY2tUcmFjZUxpbWl0XG4gIH1cbn1cblxubW9kdWxlLmV4cG9ydHMgPSBwYXJzZVxubW9kdWxlLmV4cG9ydHMuZGVmYXVsdCA9IHBhcnNlXG5tb2R1bGUuZXhwb3J0cy5wYXJzZSA9IHBhcnNlXG5tb2R1bGUuZXhwb3J0cy5zYWZlUGFyc2UgPSBzYWZlUGFyc2Vcbm1vZHVsZS5leHBvcnRzLnNjYW4gPSBmaWx0ZXJcbiJdLCJuYW1lcyI6W10sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///(ssr)/./node_modules/secure-json-parse/index.js\n");

/***/ })

};
;