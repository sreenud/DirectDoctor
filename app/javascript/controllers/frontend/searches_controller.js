/* eslint-disable prefer-destructuring */

import { Controller } from 'stimulus';

const places = require('places.js');

export default class extends Controller {
  static targets = [
    'field',
    'name',
    'near',
    'search',
    'searchTermType',
    'lat',
    'lang',
  ];

  connect() {
    this.params = {};
    if (typeof google != 'undefined') {
      this.initPlaces();
    }

    const that = this;
    document.addEventListener('autocomplete.change', function (e) {
      const { value, textValue } = e.detail;

      const searchTermType = value.split('_')['1'];
      document
        .getElementById('searchTerm')
        .setAttribute('name', searchTermType);
      that.searchTermTypeTarget.value = searchTermType;
    });
  }

  initPlaces() {
    const options = {
      componentRestrictions: { country: 'us' },
    };
    this.autocomplete = new google.maps.places.Autocomplete(
      this.fieldTarget,
      options
    );
    // this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields([
      'address_components',
      'geometry',
      'icon',
      'name',
    ]);
    this.autocomplete.addListener(
      'place_changed',
      this.placeChanged.bind(this)
    );
  }

  placeChanged() {
    const place = this.autocomplete.getPlace();
    const name = place.name;
    const near = `${place.geometry.location.lat()},${place.geometry.location.lng()}`;

    const { value } = this.nameTarget;
    const paramHash = { near, place: name };
    if (value !== undefined && value !== null && value !== '') {
      this.setParams();
    }
    this.params = paramHash;
  }

  submitSearch(event) {
    event.preventDefault();
    this.setParams();
    const queryString = new URLSearchParams(this.params || {}).toString();
    const url = `/search-map?${queryString}`;
    Turbolinks.visit(url);
  }

  setParams() {
    const value = this.nameTarget.value;
    if (value !== undefined && value !== null && value !== '') {
      if (this.searchTermTypeTarget.value == 'clinic') {
        this.params.clinic_name = value;
      } else if (this.searchTermTypeTarget.value == 'doctor') {
        this.params.doctor_name = value;
      } else {
        this.params.speciality_name = value;
      }
    }
  }
}
