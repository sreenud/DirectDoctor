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

  static values = {
    url: String,
    currentUrl: String,
  };

  connect() {
    this.containerTarget.addEventListener('click', (e) => {
      const { target } = e;
      e.preventDefault();
      if (target.nodeName === 'A') {
        const link = target.href;
        const query = link.split('?')[1];
        const paramObj = new URLSearchParams(query);
        const page = paramObj.get('page');
        const url = this.urlValue;
        console.log(url);
        const currentURL = this.currentUrlValue;
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
              window.scrollTo(0, 0);
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
