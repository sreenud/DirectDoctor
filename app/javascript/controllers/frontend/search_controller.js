/* eslint-disable prefer-destructuring */

import { Controller } from 'stimulus';

const places = require('places.js');

export default class extends Controller {
  static targets = ['name', 'near', 'search', 'searchTermType'];

  connect() {
    this.params = {};
    const nearAutoComplete = places({
      appId: 'plDTKKNHYONE',
      apiKey: 'bf33910f52286f325ea02b9d06f14f53',
      container: '#near',
    }).configure({
      countries: ['us', 'in'],
      type: ['city', 'address', 'townhall', 'trainStation', 'airport'],
      aroundLatLngViaIP: false,
    });

    nearAutoComplete.on('change', (e) => {
      const { latlng, name } = e.suggestion;
      const near = `${latlng.lat},${latlng.lng}`;
      const { value } = this.nameTarget;
      const paramHash = { near, place: name };
      if (value !== undefined && value !== null && value !== '') {
        this.setParams();
      }
      this.params = paramHash;
    });

    this.searchTarget.addEventListener('click', (e) => {
      e.preventDefault();
      this.setParams();
      const queryString = new URLSearchParams(this.params || {}).toString();
      const url = `/search-map?${queryString}`;
      Turbolinks.visit(url);
    });

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
