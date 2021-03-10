import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['userType'];

  requestStatus(event) {
    this.userTypeTargets.forEach((el, i) => {
      if (event.target == el) {
        if (event.target.value == 'approve') {
          this.doctorFormTarget.classList.remove('hidden');
        } else if (event.target.value == 'request') {
          this.doctorFormTarget.classList.add('hidden');
        } else {
          this.doctorFormTarget.classList.add('hidden');
        }
      }
    });
    this.submitButtonTarget.classList.remove('hidden');
  }
}
