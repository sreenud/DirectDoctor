import { Controller } from 'stimulus';
import { ajax } from 'jquery';
import ParamRedirect, {
  AddHoverHighlight,
  hideLoading,
  ParamUrl,
  showLoading,
  URIPush,
} from './param_redirect';

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
            const pagination = document.querySelector('#pagination-container');
            if (!container) {
              return null;
            }
            container.innerHTML = data.results;
            pagination.innerHTML = data.pagination;
            if (
              window.map_helpers !== undefined &&
              window.map_helpers !== null
            ) {
              window.map_helpers.renderPins(data.pins || []);
              // window.map_helpers.adjustZoomLevel(data.max_distance);
            }
            URIPush({
              changeParams: formValues,
              route: '/search-map',
              removeParams: ['page', ...this.removedFilters(formValues)],
            });
            AddHoverHighlight();
            hideLoading();
            // reset pagination using a controller
            return null;
          },
          (rej) => {
            console.log(rej);
            hideLoading();
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

  removedFilters(formValue) {
    // REMEMBER: make sure to change this when doctor filters are updated
    const allFields = [
      'speciality',
      'practice_type',
      'rating',
      'holistic_medicine',
      'experience',
      'telehealth',
      'life_style_medicine',
      'price',
    ];
    const keys = Object.keys(formValue);

    return allFields.filter((a) => keys.indexOf(a) < 0);
  }

  getResults() {
    showLoading();
    return ajax({
      url: ParamUrl({
        changeParams: this.formValue(this.formTarget),
        removeParams: ['page'],
        route: '/search-map.json',
      }),
    });
  }
}
