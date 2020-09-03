import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['slug'];

  updateSlug(event) {
    if (event.target.getAttribute('data-record') != 'false') {
      let slug = event.target.value.toLowerCase().replace(/[^0-9a-zA-Z]/g, '-');
      while (slug.charAt(slug.length - 1) == '-') slug = slug.replace(/.$/, '');
      this.slugTarget.value = slug;
    }
  }
}
