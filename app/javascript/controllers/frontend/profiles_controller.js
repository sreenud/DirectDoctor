import { Controller } from 'stimulus';
import { customIcon } from './map_pin_generator';

const { GMaps } = window;

export default class extends Controller {
  connect() {
    this.currentLocation = { ...this.defaultLocation() };
    this.map = new GMaps({
      div: '#map',
      zoom: 12,
      lat: this.currentLocation.lat,
      lng: this.currentLocation.lng,
      zoomControl: false,
      fullscreenControl: false,
      mapTypeControl: false,
    });
    this.addPin();
  }

  addPin() {
    const icon = customIcon({ multiple: true, color: '#e7ab00' });
    this.map.addMarker({ ...this.defaultLocation(), icon, label: '•' });
  }

  defaultLocation() {
    const coord = this.data
      .get('location')
      .split(',')
      .map((a) => parseFloat(a));

    return { lat: coord[0], lng: coord[1] };
  }
}
