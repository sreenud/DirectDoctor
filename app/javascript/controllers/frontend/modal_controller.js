import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {}

  modalOpen(event) {
    var modalTarget = event.target.getAttribute('data-modal');
    document.getElementById(modalTarget).classList.toggle('opacity-0');
    document
      .getElementById(modalTarget)
      .classList.toggle('pointer-events-none');
  }

  modalClose(event) {
    var modalTarget = event.target.closest('.modal').getAttribute('id');
    document.getElementById(modalTarget).classList.toggle('opacity-0');
    document
      .getElementById(modalTarget)
      .classList.toggle('pointer-events-none');
  }
}
