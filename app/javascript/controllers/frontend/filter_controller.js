import { Controller } from 'stimulus';
import ParamRedirect from './param_redirect';

export default class FilterController extends Controller {
  static targets = ['form'];

  connect() {
    this.timeout = null;
    this.formTarget.addEventListener('change', (_e) => {
      clearTimeout(this.timeout);
      const formValues = this.formValue(this.formTarget);
      this.timeout = setTimeout(() => {
        ParamRedirect({
          changeParams: formValues,
          route: '/search-map',
        });
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
}
