import { Controller } from 'stimulus';

const places = require('places.js');

export default class extends Controller {
  static targets = ['name', 'near', 'search'];

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
        paramHash.speciality_name = value;
      }
      this.params = paramHash;
    });

    this.nameTarget.addEventListener('change', (e) => {
      this.params.speciality_name = this.nameTarget.value;
    });

    this.searchTarget.addEventListener('click', (e) => {
      e.preventDefault();
      const queryString = new URLSearchParams(this.params || {}).toString();
      const url = `/search-map?${queryString}`;
      Turbolinks.visit(url);
    });
  }
}
