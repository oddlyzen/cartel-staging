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

function initAutocompleteExhibition() {
  var input = (document.getElementsByClassName('google-places-autocomplete-exhibition')[0])
  if (input) {
    autocompleteExhibition = new google.maps.places.Autocomplete(input, options);

    autocompleteExhibition.addListener('place_changed', function() {

      var place = autocompleteExhibition.getPlace();

      $('.location-state-exhibition').val(place.address_components[0].long_name);
      $('.location-country-exhibition').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}

function initAutocompleteExperience() {
  var input = (document.getElementsByClassName('google-places-autocomplete-experience')[0])
  if (input) {
    autocompleteExperience = new google.maps.places.Autocomplete(input, options);

    autocompleteExperience.addListener('place_changed', function() {
      var place = autocompleteExperience.getPlace();

      $('.location-state-experience').val(place.address_components[0].long_name);
      $('.location-country-experience').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}

function initAutocompleteAward() {
  var input = (document.getElementsByClassName('google-places-autocomplete-award')[0])
  if (input) {
    autocompleteAward = new google.maps.places.Autocomplete(input, options);

    autocompleteAward.addListener('place_changed', function() {
      var place = autocompleteAward.getPlace();

      $('.location-state-award').val(place.address_components[0].long_name);
      $('.location-country-award').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}

function initAutocompleteEducation() {
  var input = (document.getElementsByClassName('google-places-autocomplete-education')[0])
  if (input) {
    autocompleteEducation = new google.maps.places.Autocomplete(input, options);

    autocompleteEducation.addListener('place_changed', function() {
      var place = autocompleteEducation.getPlace();

      $('.location-state-education').val(place.address_components[0].long_name);
      $('.location-country-education').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}

function initAutocompleteResidency() {
  var input = (document.getElementsByClassName('google-places-autocomplete-residency')[0])
  if (input) {
    autocompleteResidency = new google.maps.places.Autocomplete(input, options);

    autocompleteResidency.addListener('place_changed', function() {
      var place = autocompleteResidency.getPlace();

      $('.location-state-residency').val(place.address_components[0].long_name);
      $('.location-country-residency').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}

function initAutocompletePublication() {
  var input = (document.getElementsByClassName('google-places-autocomplete-publication')[0])
  if (input) {
    autocompletePublication = new google.maps.places.Autocomplete(input, options);

    autocompletePublication.addListener('place_changed', function() {
      var place = autocompletePublication.getPlace();

      $('.location-state-publication').val(place.address_components[0].long_name);
      $('.location-country-publication').val(place.address_components[place.address_components.length - 1].long_name);
    });
  }
}

$(document).ready(function() {
  initAutocomplete();
  initAutocompleteExhibition();
  initAutocompleteExperience();
  initAutocompleteAward();
  initAutocompleteEducation();
  initAutocompleteResidency();
  initAutocompletePublication();
})
