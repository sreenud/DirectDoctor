import { Controller } from 'stimulus';
import { ajax } from 'jquery';
import ParamRedirect, {
  AddHoverHighlight,
  hideLoading,
  locationParams,
  ParamUrl,
  showLoading,
  URIPush,
} from './param_redirect';
import MapPinGenerator, { customIcon } from './map_pin_generator';

const { GMaps } = window;

export default class extends Controller {
  connect() {
    AddHoverHighlight();
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
        this.getResults({ lat, lng });
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
    return new MapPinGenerator(pinArray).groupedMarkers();
  }

  setPopups() {
    const pins = this.generatePopups();
    this.setPins(pins);
    // console.log(this.maps.addMarkers(pins));
    // pins.forEach((pin) => this.maps.drawOverlay(pin));
  }

  setPins(pins = []) {
    pins.forEach((pin) => {
      const { ids, lat, lng, icon, label, infoWindow } = pin;
      const marker = this.maps.addMarker({ lat, lng, icon, label, infoWindow });
      ids.forEach((id) => {
        const card = document.querySelector(`#doc-${id}`);
        card.addEventListener('mouseenter', () => {
          marker.setIcon(customIcon('#e7ab00'));
        });
        card.addEventListener('mouseleave', () => {
          marker.setIcon(customIcon('white'));
        });
      });
      window.google.maps.event.addListener(marker, 'mouseover', () => {
        marker.setIcon(customIcon('#e7ab00'));
      });
      window.google.maps.event.addListener(marker, 'mouseout', () => {
        marker.setIcon(customIcon('white'));
      });
    });
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

  popup(price, id) {
    return `<div class="popup-container" id="doc-${id}-popup" tab-index="1">
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
    this.maps.removeMarkers();
    const pins = this.pinData(pinArray);
    // pins.forEach((pin) => this.maps.drawOverlay(pin));
    this.setPins(pins);
  }

  adjustZoomLevel(distance = 20) {
    const target = this.defaultZoom(distance);
    this.maps.setZoom(target);
  }

  getResults({ lat, lng }) {
    const near = `${lat},${lng}`;
    showLoading();
    ajax({
      url: ParamUrl({
        changeParams: { near },
        route: '/search-map.json',
        removeParams: ['place', 'page'],
      }),
    }).then(
      // eslint-disable-next-line camelcase
      ({ results, pins, max_distance, pagination }) => {
        const container = document.querySelector('#result-container');
        const paginationContainer = document.querySelector(
          '#pagination-container'
        );
        if (!container) {
          return null;
        }
        container.innerHTML = results;
        paginationContainer.innerHTML = pagination;
        if (window.map_helpers !== undefined && window.map_helpers !== null) {
          window.map_helpers.renderPins(pins || []);
          window.map_helpers.adjustZoomLevel(max_distance);
        }
        URIPush({
          changeParams: { near },
          route: '/search-map',
          removeParams: ['place', 'page'],
        });
        AddHoverHighlight();
        hideLoading();
        return null;
      },
      (err) => {
        console.log(err);
        hideLoading();
      }
    );
  }
}
