import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['consentPopup'];

  connect() {
    const storageType = 'accept_cookies';
    if (!this.shouldShowPopup(storageType)) {
      this.consentPopupTarget.classList.remove('hidden');
    }
  }

  saveToStorage(storageType) {
    window.localStorage.setItem(storageType, true);
  }

  shouldShowPopup(storageType) {
    return this.getFromStorage(storageType);
  }

  accept() {
    const storageType = 'accept_cookies';
    this.saveToStorage(storageType);
    this.consentPopupTarget.classList.add('hidden');
  }

  getFromStorage(item) {
    return window.localStorage.getItem(item);
  }
}
