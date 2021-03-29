import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['unlikeClass', 'likeClass'];

  static values = {
    url: String,
  };

  like() {
    const url = this.urlValue;
    fetch(url, {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token'),
      },
    })
      .then((response) => response.text())
      .then((data) => {
        const responseData = JSON.parse(data);
        if (responseData.success == true) {
          this.likeClassTarget.classList.remove('text-gray-600');
          this.likeClassTarget.classList.add('text-green-500');
        }
      });
  }

  unlike() {
    const url = this.urlValue;

    fetch(url, {
      method: 'DELETE',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token'),
      },
    })
      .then((response) => response.text())
      .then((data) => {
        const responseData = JSON.parse(data);
        if (responseData.success == true) {
          this.likeClassTarget.classList.add('text-gray-600');
          this.likeClassTarget.classList.remove('text-green-500');
        }
      });
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute('content');
  }
}
