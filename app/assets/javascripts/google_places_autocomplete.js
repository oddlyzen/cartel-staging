var placeSearch, autocomplete;
var options = {
  types: ['(cities)']
};

function initAutocomplete() {
  var input = (document.getElementsByClassName('google-places-autocomplete')[0])
  if (input) {
    autocomplete = new google.maps.places.Autocomplete(input, options);
  }
}
