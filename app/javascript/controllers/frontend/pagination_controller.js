import { ajax } from 'jquery';
import { Controller } from 'stimulus';
import {
  AddHoverHighlight,
  hideLoading,
  ParamUrl,
  showLoading,
  URIPush,
} from './param_redirect';

export default class extends Controller {
  static targets = ['container'];

  connect() {
    this.containerTarget.addEventListener('click', (e) => {
      const { target } = e;
      e.preventDefault();
      if (target.nodeName === 'A') {
        const link = target.href;
        const query = link.split('?')[1];
        const paramObj = new URLSearchParams(query);
        const page = paramObj.get('page');
        const url = this.data.get('url');
        const currentURL = this.data.get('currentUrl');

        if (page !== undefined && page !== null && page !== '') {
          showLoading();
          ajax({
            url: ParamUrl({
              changeParams: { page },
              route: url,
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
              if (
                window.map_helpers !== undefined &&
                window.map_helpers !== null
              ) {
                window.map_helpers.renderPins(pins || []);
                // window.map_helpers.adjustZoomLevel(max_distance);
              }
              URIPush({
                changeParams: { page },
                route: `${currentURL}`,
              });
              AddHoverHighlight();
              hideLoading();
              return null;
            },
            (_err) => {
              hideLoading();
            }
          );
        }
      }
    });
  }
}
