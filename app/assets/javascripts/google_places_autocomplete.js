var placeSearch, autocomplete;
var options = {
  types: ['(cities)']
};

function initAutocomplete() {
  var input = (document.getElementsByClassName('google-places-autocomplete')[0])
  if (input) {
    autocomplete = new google.maps.places.Autocomplete(input, options);

    autocomplete.addListener('place_changed', function() {
      var place = autocomplete.getPlace();

      $('.location-state').val(place.address_components[0].long_name);
      $('.location-country').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}
