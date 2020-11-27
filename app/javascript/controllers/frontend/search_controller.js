import { Controller } from 'stimulus';

const places = require('places.js');

export default class extends Controller {
  static targets = ['name', 'near'];

  connect() {
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
      const { value } = this.nameTarget.value;
      const paramHash = { near, place: name };
      if (value !== undefined && value !== null && value !== '') {
        paramHash.name = value;
      }
      const params = new URLSearchParams(paramHash).toString();
      const url = `/search-map?${params}`;
      Turbolinks.visit(url);
    });
  }
}
