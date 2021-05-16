import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {}

  filterClick() {
    document.getElementsByClassName('sidebar')[0].classList.toggle('hidden');
  }

  cityList(event) {
    document.getElementById('city-list').classList.toggle('h-32');
    var targetEvent = event.target;
    if (targetEvent.innerHTML === 'See more cities') {
      targetEvent.innerHTML = 'See less cities';
    } else {
      targetEvent.innerHTML = 'See more cities';
    }
  }
}
