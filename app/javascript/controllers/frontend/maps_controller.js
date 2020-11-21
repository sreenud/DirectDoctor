import gmaps from 'gmaps';
import { Controller } from 'stimulus';
import * as GMaps from 'gmaps/gmaps.min';

export default class extends Controller {
  connect() {
    // defaults to new york
    this.currentLocation = {
      lat: 40.73061,
      lng: -73.935242,
    };
    this.locationParams();
    this.maps = new GMaps({
      div: '#map',
      lat: this.currentLocation.lat,
      lng: this.currentLocation.lng,
      zoom: 12,
      // zoomControl: false,
      fullscreenControl: false,
      dragend: (e) => {
        const { center } = e;
        const lat = center.lat();
        const lng = center.lng();
        this.redirect({ lat, lng });
      },
      // zoom_changed: (e) => {
      //   const { center } = e;
      //   const lat = center.lat();
      //   const lng = center.lng();
      //   this.redirect({ lat, lng });
      // },
    });
    this.setPins();
  }

  redirect({ lat, lng }) {
    const params = this.locationParams();
    params.near = `${lat},${lng}`;
    delete params.place;
    const query = new URLSearchParams(params).toString();
    Turbolinks.visit(`/search-map?${query}`);
  }

  setPins() {
    const pins = this.data
      .get('pins')
      .split('|')
      .map((a, index) => {
        const coord = a.split(',');
        return {
          lat: coord[0],
          lng: coord[1],
          title: `Result ${index}`,
        };
      });
    this.maps.addMarkers(pins);
    this.maps.fitZoom();
  }

  locationParams() {
    const query = window.location.search;
    const paramStore = new URLSearchParams(query);
    const paramKeys = Array.from(paramStore.keys());
    const params = {};
    paramKeys.forEach((key) => {
      params[key] = paramStore.get(key);
    });
    if (params.near !== undefined && params.near !== null) {
      const coord = params.near.split(',').map((p) => parseFloat(p));
      this.currentLocation = {
        lat: coord[0],
        lng: coord[1],
      };
    }
    return params;
  }
}
