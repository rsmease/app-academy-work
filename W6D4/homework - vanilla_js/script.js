document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });



  // adding SF places as list items

  // --- your code here!
  // const favoritePlaceForm = document.getElementById("favorites-form");
  // favoritePlaceForm.addEventListener("submit", event => {
  //   event.preventDefault();
  //
  //   const nameInputEl = document.getElementsByClassName("favorite-input");
  //   const nameInput = document.nameInputEl.value;
  //   nameInputEl.value = "";
  //
    // const ul = document.getElementById("sf-places");
    // const li = document.createElement("li");
    // li.textContent = nameInput;
  //
  //   ul.appendChild(li);
  // });

  const handleFavoriteSubmit = (e) => {
    e.preventDefault();

    const nameInputEl = document.querySelector(".favorite-input");
    const nameInput = nameInputEl.value;
    nameInputEl.value = "";

    const placesList = document.getElementById("sf-places");
    const li = document.createElement("li");
    li.textContent = nameInput;

    placesList.appendChild(li);

  };

  const favoritePlacesSubmitButton = document.querySelector(".favorite-submit");
  favoritePlacesSubmitButton.addEventListener("click", handleFavoriteSubmit);




  // adding new photos

  // --- your code here!
  const togglePuppyForm = (e) => {
    // e.preventDefault();

    const puppyForm = document.querySelector(".photo-form-container");
    if (puppyForm.className === "photo-form-container") {
      puppyForm.className = "photo-form-container hidden";
    } else {
      puppyForm.className = "photo-form-container";
    }
  };

  const showFormButton = document.querySelector(".photo-show-button");
  showFormButton.addEventListener("click", togglePuppyForm);

  const handlePuppyFormSubmit = (e) => {
    e.preventDefault();

    const imageInputEl = document.querySelector(".photo-url-input");
    const imageInputURL = imageInputEl.value;
    imageInputEl.value = "";

    const newPuppyImg = document.createElement("img");
    newPuppyImg.src = imageInputURL;

    const puppiesGallery = document.querySelector(".dog-photos");
    const li = document.createElement("li");

    li.appendChild(newPuppyImg);
    puppiesGallery.appendChild(li);
  };

  const puppySubmitButton = document.querySelector(".photo-url-submit");
  puppySubmitButton.addEventListener("click", handlePuppyFormSubmit);




});
