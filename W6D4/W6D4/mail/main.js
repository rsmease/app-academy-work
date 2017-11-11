const Router = require('./router.js');
const Inbox = require('./inbox.js');

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
