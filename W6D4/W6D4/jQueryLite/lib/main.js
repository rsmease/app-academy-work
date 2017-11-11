const DOMNodeCollection = require('./dom_node_collection.js');

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
