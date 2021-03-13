import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    'buttonStatus',
    'doctorForm',
    'status',
    'errors',
    'success',
    'commentList',
  ];

  requestStatus(event) {
    this.buttonStatusTargets.forEach((el, i) => {
      if (event.target == el) {
        if (event.target.value == 'approve') {
          this.statusTarget.value = 'approve';
          this.doctorFormTarget.classList.remove('hidden');
        } else if (event.target.value == 'follow_up') {
          this.doctorFormTarget.classList.remove('hidden');
          this.statusTarget.value = 'follow_up';
        } else {
          this.doctorFormTarget.classList.remove('hidden');
          this.statusTarget.value = 'reject';
        }
      }
    });
    // this.submitButtonTarget.classList.remove('hidden');
  }

  success(event) {
    this.doctorFormTarget.classList.add('hidden');
    const [data, status, xhr] = event.detail;
    this.commentListTarget.innerHTML = data.html;
    this.successTarget.innerHTML = data.message;
    this.errorsTarget.innerHTML = '';
  }

  errorHandler(event) {
    const [data, status, xhr] = event.detail;
    // xhr.response
    this.errorsTarget.innerHTML = "can't be blank";
  }
}
