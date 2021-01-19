import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {}

  modalOpen(event) {
    var modalTarget = event.target.getAttribute('data-modal');
    const modal = document.getElementById(modalTarget);
    if (!modal) {
      return;
    }
    const fbButton = modal.querySelector('a.a2a_button_facebook');
    if (!!fbButton && fbButton.innerHTML < 1 && !!window.a2a) {
      window.a2a_config.target = '.a2a_target';
      window.a2a.init('page');
    }
    modal.classList.toggle('opacity-0');
    modal.classList.toggle('pointer-events-none');
  }

  modalClose(event) {
    var modalTarget = event.target.closest('.modal').getAttribute('id');
    const modal = document.getElementById(modalTarget);
    if (!modal) {
      return;
    }
    modal.classList.toggle('opacity-0');
    modal.classList.toggle('pointer-events-none');
  }
}
