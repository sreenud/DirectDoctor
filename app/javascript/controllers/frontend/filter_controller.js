import { Controller } from 'stimulus';
import { ajax } from 'jquery';
import ParamRedirect, { ParamUrl, URIPush } from './param_redirect';

export default class FilterController extends Controller {
  static targets = ['form'];

  connect() {
    this.timeout = null;
    this.formTarget.addEventListener('change', (_e) => {
      clearTimeout(this.timeout);
      const formValues = this.formValue(this.formTarget);
      this.timeout = setTimeout(() => {
        this.getResults().then(
          (data) => {
            const container = document.querySelector('#result-container');
            if (!container) {
              return null;
            }
            container.innerHTML = data.results;
            if (
              window.map_helpers !== undefined &&
              window.map_helpers !== null
            ) {
              window.map_helpers.renderPins(data.pins || []);
            }
            URIPush({
              changeParams: formValues,
              route: '/search-map',
              removeParams: ['page'],
            });
            // reset pagination using a controller
            return null;
          },
          (rej) => {
            console.log(rej);
          }
        );
      }, 1000);
    });
  }

  formValue(form) {
    const data = new FormData(form);
    const keys = Array.from(new Set(data.keys()));
    const formHash = {};
    keys.forEach((key) => {
      const val = data.getAll(key);
      formHash[key] = val.length > 1 ? val : val[0];
    });
    return formHash;
  }

  getResults() {
    return ajax({
      url: ParamUrl({
        changeParams: this.formValue(this.formTarget),
        removeParams: ['page'],
        route: '/search-map.json',
      }),
    });
  }
}
