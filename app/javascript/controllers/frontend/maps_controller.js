import { Controller } from 'stimulus';
import * as GMaps from 'gmaps/gmaps.min';
import MapPopup from './map_popup';
import ParamRedirect, { locationParams } from './param_redirect';

export default class extends Controller {
  connect() {
    window.map_helpers = {
      renderPins: this.renderPins.bind(this),
      adjustZoomLevel: this.adjustZoomLevel.bind(this),
    };
    // defaults to new york
    this.currentLocation = { ...this.defaultLocation() };
    this.paramters();
    this.maps = new GMaps({
      div: '#map',
      lat: this.currentLocation.lat,
      lng: this.currentLocation.lng,
      zoom: this.defaultZoom(),
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
    // this.setPins();
    this.setPopups();
  }

  redirect({ lat, lng }) {
    const near = `${lat},${lng}`;
    ParamRedirect({
      changeParams: { near },
      removeParams: ['place'],
      route: '/search-map',
    });
  }

  generatePopups() {
    const pins = this.pinData(
      this.data
        .get('pins')
        .split('|')
        .filter((a) => a.length > 1)
    );
    return pins;
  }

  pinData(pinArray = []) {
    return pinArray.map((a) => {
      const coord = a.split(',');
      return {
        lat: coord[0],
        lng: coord[1],
        content: this.popup(coord[2] || 'no price'),
        click: (overlay) => {
          const popup = new MapPopup(overlay.el, coord);
          popup.show();
        },
      };
    });
  }

  setPopups() {
    const pins = this.generatePopups();
    pins.forEach((pin) => this.maps.drawOverlay(pin));
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
          label: coord[2] || 'no price',
        };
      });
    this.maps.addMarkers(pins);
    // pins.forEach((pin) => this.addMarker(pin));
    this.maps.fitZoom();
  }

  paramters() {
    const params = locationParams();
    if (params.near !== undefined && params.near !== null) {
      const coord = params.near.split(',').map((p) => parseFloat(p));
      this.currentLocation = {
        lat: coord[0],
        lng: coord[1],
      };
    }
    return params;
  }

  popup(price) {
    return `<div class="popup-container" tab-index="1">
      <div class="popup-bubble-anchor">
        <div class="popup-bubble">${price}</div>
      </div>
    </div>`;
  }

  defaultLocation() {
    const coord = this.data
      .get('defaultlocation')
      .split(',')
      .map((a) => parseFloat(a));
    return { lat: coord[0], lng: coord[1] };
  }

  defaultZoom(distance = parseFloat(this.data.get('distance') || '0') || 20) {
    let zoom = 8;
    if (distance > 20 && distance <= 50) {
      zoom = 7;
    } else if (distance > 50 && distance <= 100) {
      zoom = 6;
    } else if (distance > 100 && distance <= 200) {
      zoom = 5;
    } else if (distance > 200 && distance <= 500) {
      zoom = 4;
    } else if (distance > 500 && distance <= 1000) {
      zoom = 3;
    } else if (distance > 1000 && distance <= 2000) {
      zoom = 2;
    } else if (distance > 2000) {
      zoom = 1;
    }
    return zoom;
  }

  renderPins(pinArray = ["0.0, 0.0, '', ''"]) {
    this.maps.removeOverlays();
    const pins = this.pinData(pinArray);
    pins.forEach((pin) => this.maps.drawOverlay(pin));
  }

  adjustZoomLevel(distance = 20) {
    const target = this.defaultZoom(distance);
    this.maps.setZoom(target);
  }
}
