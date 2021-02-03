import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {}

  filterClick() {
    document.getElementsByClassName('sidebar')[0].classList.toggle('hidden');
  }
}
