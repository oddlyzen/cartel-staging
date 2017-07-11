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
  $('.google-places-autocomplete-exhibition').each(function(index, input) {
    if (input) {
      autocompleteExhibition = new google.maps.places.Autocomplete(input, options);

      autocompleteExhibition.addListener('place_changed', function() {

        var place = autocompleteExhibition.getPlace();

        $(input).parent().siblings('.location-state-exhibition').val(place.address_components[0].long_name);
        $(input).parent().siblings('.location-country-exhibition').val(place.address_components[place.address_components.length - 1].long_name);
      });
    }
  });
}

function initAutocompleteExperience() {
  $('.google-places-autocomplete-experience').each(function(index, input) {
    if (input) {
      autocompleteExperience = new google.maps.places.Autocomplete(input, options);

      autocompleteExperience.addListener('place_changed', function() {
        var place = autocompleteExperience.getPlace();

        $(input).parent().siblings('.location-state-experience').val(place.address_components[0].long_name);
        $(input).parent().siblings('.location-country-experience').val(place.address_components[place.address_components.length - 1].long_name);
      });
    }
  });
}

function initAutocompleteAward() {
  $('.google-places-autocomplete-award').each(function(index, input) {
    if (input) {
      autocompleteAward = new google.maps.places.Autocomplete(input, options);

      autocompleteAward.addListener('place_changed', function() {
        var place = autocompleteAward.getPlace();

        $(input).parent().siblings('.location-state-award').val(place.address_components[0].long_name);
        $(input).parent().siblings('.location-country-award').val(place.address_components[place.address_components.length - 1].long_name);
      });
    }
  });
}

function initAutocompleteEducation() {
  $('.google-places-autocomplete-education').each(function(index, input) {
    if (input) {
      autocompleteEducation = new google.maps.places.Autocomplete(input, options);

      autocompleteEducation.addListener('place_changed', function() {
        var place = autocompleteEducation.getPlace();

        $(input).parent().siblings('.location-state-education').val(place.address_components[0].long_name);
        $(input).parent().siblings('.location-country-education').val(place.address_components[place.address_components.length - 1].long_name);
      });
    }
  })
}

function initAutocompleteResidency() {
  $('.google-places-autocomplete-residency').each(function(index, input) {
    if (input) {
      autocompleteResidency = new google.maps.places.Autocomplete(input, options);

      autocompleteResidency.addListener('place_changed', function() {
        var place = autocompleteResidency.getPlace();

        $(input).parent().siblings('.location-state-residency').val(place.address_components[0].long_name);
        $(input).parent().siblings('.location-country-residency').val(place.address_components[place.address_components.length - 1].long_name);
      });
    }
  })
}

function initAutocompletePublication() {
  $('.google-places-autocomplete-publication').each(function(index, input) {
    if (input) {
      autocompletePublication = new google.maps.places.Autocomplete(input, options);

      autocompletePublication.addListener('place_changed', function() {
        var place = autocompletePublication.getPlace();

        $(input).parent().siblings('.location-state-publication').val(place.address_components[0].long_name);
        $(input).parent().siblings('.location-country-publication').val(place.address_components[place.address_components.length - 1].long_name);
      });
    }
  });
}

$(document).ready(function() {
  initAutocomplete();
  initAutocompleteExhibition();
  initAutocompleteExperience();
  initAutocompleteAward();
  initAutocompleteEducation();
  initAutocompleteResidency();
  initAutocompletePublication();

  $('.add_fields').on("mouseup", function() {
    setTimeout(function() {
      initAutocomplete();
      initAutocompleteExhibition();
      initAutocompleteExperience();
      initAutocompleteAward();
      initAutocompleteEducation();
      initAutocompleteResidency();
      initAutocompletePublication();
    }, 100);
  });
})
