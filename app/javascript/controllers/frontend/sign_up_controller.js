import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['acceptCheck', 'signUpButton'];

  accept() {
    if (this.acceptCheckTarget.checked == true) {
      this.signUpButtonTarget.removeAttribute('disabled');
      this.signUpButtonTarget.classList.remove('bg-doctor-yellow-500');
      this.signUpButtonTarget.classList.add(
        'hover:bg-doctor-yellow',
        'hover:text-gray-100',
        'bg-doctor-yellow'
      );
    } else {
      this.signUpButtonTarget.setAttribute('disabled', true);
      this.signUpButtonTarget.classList.remove(
        'hover:bg-doctor-yellow',
        'hover:text-gray-100',
        'bg-doctor-yellow'
      );
      this.signUpButtonTarget.classList.add('bg-doctor-yellow-500');
    }
  }
}
