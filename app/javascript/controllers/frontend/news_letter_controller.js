import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['errors', 'success', 'email', 'emailError'];

  success(event) {
    const [data, status, xhr] = event.detail;
    this.successTarget.classList.add('text-blue-600');
    this.successTarget.innerHTML = 'Thank you for subscribing!';
    this.errorsTarget.innerHTML = '';
  }

  errorHandler(event) {
    const [data, status, xhr] = event.detail;
    this.emailErrorTarget.innerHTML = 'Please enter your email address';
  }
}
