import { Controller } from 'stimulus';

var places = require('places.js');

export default class extends Controller {
  static targets = ['output'];

  connect() {
    var placesAutocomplete = places({
      appId: 'plDTKKNHYONE',
      apiKey: 'bf33910f52286f325ea02b9d06f14f53',
      container: document.querySelector('#doctor_address_line_1'),
      templates: {
        value: function (suggestion) {
          return suggestion.name;
        },
      },
    }).configure({
      type: 'address',
      countries: ['us'],
    });

    placesAutocomplete.on('change', function resultSelected(e) {
      console.log(e.suggestion);
      document.querySelector('#doctor_state').value =
        e.suggestion.administrative || '';
      document.querySelector('#doctor_city').value = e.suggestion.city || '';
      document.querySelector('#doctor_zipcode').value =
        e.suggestion.postcode || '';
      document.querySelector('#doctor_lat').value =
        e.suggestion.latlng.lat || '';
      document.querySelector('#doctor_lng').value =
        e.suggestion.latlng.lng || '';
    });
  }
}
