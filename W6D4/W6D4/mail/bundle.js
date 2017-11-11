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

const Router = __webpack_require__(1);
const Inbox = __webpack_require__(2);

document.addEventListener("DOMContentLoaded", (e) =>{
  let content = document.querySelector(".content");
  let router = new Router(content, routes);
  router.start();
  let sideBarNav = document.querySelectorAll('.sidebar-nav li');
  sideBarNav.forEach(function(el){
    el.addEventListener("click", (event) =>{
      let innerText = event.target.innerText.toLowerCase();
      window.location.hash = innerText;
      router.render();
    });
  });
});

let routes = {
  inbox: Inbox
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    this.render();
    this.node.addEventListener("hashchange", (e) => {
      this.render();
    });
  }

  render() {
    this.node.innerHTML = "";
    let component = this.activeRoute();

    if (!(component === undefined)) {
      let resultingComponent = component.render();
      this.node.appendChild(resultingComponent);
    }

  }

  activeRoute() {
    let currHash = window.location.hash.substring(1);
    return this.routes[currHash];
  }
}

module.exports = Router;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

// let messageStore = require("./message_store.js");
//
// let Inbox = {
//   render: function() {
//     let inboxMessages = messageStore.getInboxMessages();
//     let container = document.createElement('div');
//     inboxMessages.forEach(function(el){
//       let renderedMessage = Inbox.renderMessage(el);
//       container.appendChild(renderedMessage);
//     });
//     return container;
//   },
//
//   renderMessage: function(message){
//     let newLi = document.createElement('li');
//     newLi.className = "message";
//
//     newLi.innerHTML =`
// <span class='from'>${message.from}</span>
// <span class="subject">${message.subject}</span> -
// <span class="body">${message.body}</span>
// `;
//
//
//     return newLi;
//
//   }
//
//
// };
//
//
//module.exports = Inbox;




const MessageStore = __webpack_require__(3);

module.exports = {
  renderMessage(message) {
    let messageEl = document.createElement("li");
    messageEl.className = "message";
    messageEl.innerHTML =`
    <span class='from'>${message.from}</span>
    <span class="subject">${message.subject}</span> -
    <span class="body">${message.body}</span>
    `;
    return messageEl;
  },
  render() {
    let container = document.createElement("ul");
    container.className = "messages";
    let messages = MessageStore.getInboxMessages();
    messages.forEach(message => {
      container.appendChild(this.renderMessage(message));
    });
    return container;
  }
};


/***/ }),
/* 3 */
/***/ (function(module, exports) {

let MessageStore = {

  getInboxMessages: function() { return messages.inbox; },
  getSentMessages: function() { return messages.sent; }

};

let messages = {
  sent: [
    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
    {to: "person@mail.com", subject: "zzz", body: "so booring"}
  ],
  inbox: [
    {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body:
    "Stay at home mom discovers cure for leg cramps. Doctors hate her"},
    {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"}
  ]
};


module.exports = MessageStore;


/***/ })
/******/ ]);