import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['status'];

  approve() {
    this.statusTarget.value = 'published';
    document.getElementById('admin_review_form').submit();
  }

  reject() {
    this.statusTarget.value = 'archive';
    document.getElementById('admin_review_form').submit();
  }
}
