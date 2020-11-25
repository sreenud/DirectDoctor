import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['container', 'logo'];

  connect() {
    window.loading_helper = {
      showLoading: this.showLoading.bind(this),
      hideLoading: this.hideLoading.bind(this),
    };
  }

  showLoading() {
    this.containerTarget.classList.remove('invisible');
    this.logoTarget.classList.add('animate-pulse');
  }

  hideLoading() {
    this.containerTarget.classList.add('invisible');
    this.logoTarget.classList.remove('animate-pulse');
  }
}
