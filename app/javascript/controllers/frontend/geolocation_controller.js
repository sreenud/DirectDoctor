/* eslint-disable no-unused-expressions */
/* eslint-disable no-param-reassign */
/* eslint-disable no-useless-escape */
/* eslint-disable prefer-template */

import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['link'];

  geolocate() {
    if (!navigator.geolocation) {
      this.linkTarget.textContent =
        'Geolocation is not supported in this browser.';
    } else {
      navigator.geolocation.getCurrentPosition(
        this.success.bind(this),
        this.error.bind(this)
      );
    }
  }

  success(position) {
    const latLng = `${position.coords.latitude}, ${position.coords.longitude}`;
    this.updateQueryString(latLng);
  }

  error() {
    this.linkTarget.textContent = 'Unable to get your location.';
  }

  updateQueryString(latLng) {
    const url = new URL(window.location);
    url.searchParams.has('near')
      ? url.searchParams.set('near', latLng)
      : url.searchParams.append('near', latLng);
    url.searchParams.has('place')
      ? url.searchParams.set('place', '')
      : url.searchParams.append('place', '');
    window.location = url;
  }

  urlParam(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null
      ? ''
      : decodeURIComponent(results[1].replace(/\+/g, ' '));
  }
}
