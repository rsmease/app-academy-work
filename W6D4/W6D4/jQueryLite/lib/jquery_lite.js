/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

function $foo(arg){
  if (arg instanceof HTMLElement) {
    let currDOMCollection = new DOMNodeCollection([arg]);
    return currDOMCollection;
  } else {
    let NodeList = document.querySelectorAll(arg);
    let currDOMCollection = new DOMNodeCollection(Array.from(NodeList));
    return currDOMCollection;

  }
}

window.$foo = $foo;


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(array) {
      this.array = array;
  }

  html(string = null) {
    if (string === null) {
      return this.array[0].innerHTML;
    } else {
      this.array.map(function(el) {
        el.innerHTML = string;
      });
    }
  }
  empty(){
    this.array.map(function(el){
      el.innerHTML = "";
    });
  }

  append(arg){
    this.array.forEach(function(el){
        // debugger;
      if (typeof arg === "string") {
        el.innerHTML += arg;
      } else if (arg instanceof DOMNodeCollection) {
        for (var i = 0; i < arg.length; i++) {
          el.appendChild(arg[i]);
        }
      } else {
        el.appendChild(arg);
      }

    });

  }

  attr(attributeName,value){
    let first = this.array[0];
    if (value === undefined) {
      return first.getAttribute(attributeName);
    } else if (typeof value === "string" ) {
      first.setAttribute(attributeName,value);
    }
  }

  addClass(newClass) {
    this.array.forEach(function(el) {
      if (el.className === "") {
        el.className += newClass;
      } else {
        el.className += (" " + newClass);
      }
    });
  }

  removeClass(targetClass) {
    if (targetClass === undefined) {
      this.array.forEach(function(el) {
        el.className = "";
      });
    } else {
      this.array.forEach(function(el) {
        let target = el.className.split(" ");
        target = target.filter(name => name !== targetClass);
        el.className = target.join(" ");
      });
    }
  }

  children() {
    let children = this.array.map(el => el.children);
    return new DOMNodeCollection(children.filter(el => el.length > 0));
  }

  parent() {
    let parents = this.array.map(el => el.parent);
    return new DOMNodeCollection(parent.filter(el => el.length > 0));
  }


}






module.exports = DOMNodeCollection;


/***/ })
/******/ ]);