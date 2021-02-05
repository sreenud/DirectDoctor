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
  static targets = ['form', 'near', 'clear'];

  connect() {
    this.timeout = null;
    this.formTarget.addEventListener('change', (_e) => {
      clearTimeout(this.timeout);
      this.timeout = setTimeout(() => {
        this.buildResults();
      }, 1000);
    });

    this.clearTarget.addEventListener('click', (ev) => {
      ev.preventDefault();
      window.history.pushState(
        { clear_filters: true },
        'clear filters',
        'search-map'
      );
      this.resetForm(this.formTarget);
      this.buildResults();
      return false;
    });
  }

  formValue(form) {
    const data = new FormData(form);
    const keys = Array.from(new Set(data.keys()));
    const formHash = {};
    keys.forEach((key) => {
      const val = data.getAll(key);
      if (val !== undefined && val !== null && val !== '') {
        formHash[key] = val.length > 1 ? val : val[0];
      }
      if (key === 'near' && val && val !== '') {
        this.nearTarget.value = null;
      }
    });
    return formHash;
  }

  resetForm(form) {
    const { elements } = form;
    form.reset();
    for (let i = 0; i < elements.length; i++) {
      const fieldType = elements[i].type.toLowerCase();
      switch (fieldType) {
        case 'text':
        case 'password':
        case 'textarea':
        case 'hidden':
          elements[i].value = '';
          break;

        case 'radio':
        case 'checkbox':
          if (elements[i].checked) {
            elements[i].checked = false;
          }
          break;

        case 'select-one':
        case 'select-multi':
          elements[i].selectedIndex = -1;
          break;

        default:
          break;
      }
    }
  }

  buildResults() {
    document.querySelector('#search-side-bar').classList.add('hidden');
    const formValues = this.formValue(this.formTarget);
    this.getResults().then(
      (data) => {
        const container = document.querySelector('#result-container');
        const pagination = document.querySelector('#pagination-container');
        const searchResultsCount = document.querySelector(
          '#search_results_count'
        );
        if (!container) {
          return null;
        }
        container.innerHTML = data.results;
        pagination.innerHTML = data.pagination;
        searchResultsCount.innerHTML = data.total_records;

        if (window.map_helpers !== undefined && window.map_helpers !== null) {
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
