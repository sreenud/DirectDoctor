import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['errors', 'success'];

  success(event) {
    const [data, status, xhr] = event.detail;
    this.successTarget.innerHTML = data.message;
    this.errorsTarget.innerHTML = '';
  }

  errorHandler(event) {
    const [data, status, xhr] = event.detail;
    this.errorsTarget.innerHTML = xhr.response;
  }
}
