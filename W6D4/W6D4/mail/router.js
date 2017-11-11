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
