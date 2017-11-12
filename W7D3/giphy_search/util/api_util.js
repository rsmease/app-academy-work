export const fetchSearchGiphys = (searchTerm) => {
  return $.ajax({
    method: 'GET',
    url:
    `https://api.giphy.com/v1/gifs/search?api_key=WowLIPJbsZymHSrRfupBUX9hdPH0AB13&q=${searchTerm}&limit=2&offset=0&rating=G&lang=en`,
    response: function() {
      console.log("Success!");
    }
  });
};
