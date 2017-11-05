console.log("Bonjour de la console JavaScript!");

// Your AJAX request here
$.ajax({
  type: 'GET',
  url: 'http://api.openweathermap.org/data/2.5/weather?q=Paris,Fr&appid=1ec71e86f83cb7c6d09e15d79551cf95',
  success(data) {
    console.log("A Paris, maintenant, c'est...");
    console.log(data);
    console.log("Merci pour visiter.");
  },
  error() {
    console.error("Il y allait un erreur.");
  }

});
// Add another console log here, outside your AJAX request
// console.log("Merci pour visiter.");
//
