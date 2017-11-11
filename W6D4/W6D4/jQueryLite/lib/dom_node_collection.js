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
