/* eslint-disable dot-notation */
/* eslint-disable no-restricted-syntax */

import { Controller } from 'stimulus';

const reviewInputFields = [
  'rating',
  'title',
  'review',
  'treated_by_doctor',
  'will_you_recommend',
  'anonymous',
  'name',
  'email',
];

export default class extends Controller {
  static targets = [
    'errors',
    'success',
    'review',
    'title',
    'titleCount',
    'reviewCount',
    'form',
  ];

  initialize() {
    this.titleCharCount();
    this.reviewCharCount();
  }

  success(event) {
    const [data, status, xhr] = event.detail;
    this.successTarget.innerHTML = xhr.response;
    this.errorsTarget.innerHTML = '';
  }

  errorHandler(event) {
    const [data, status, xhr] = event.detail;
    const errors = JSON.parse(xhr.response);

    this.showErrors(errors['messages'] || {});
    // this.errorsTarget.innerHTML = xhr.response;
  }

  titleCharCount() {
    const maxLen = 120;
    if (this.titleTarget.value.length > maxLen) {
      this.titleTarget.value = this.titleTarget.value.substr(0, maxLen);
    }
    const charLeft = maxLen - this.titleTarget.value.length;
    this.titleCountTarget.textContent = charLeft;
  }

  reviewCharCount() {
    const maxLen = 2000;
    if (this.reviewTarget.value.length > maxLen) {
      this.reviewTarget.value = this.reviewTarget.value.substr(0, maxLen);
    }
    const charLeft = maxLen - this.reviewTarget.value.length;
    this.reviewCountTarget.textContent = charLeft;
  }

  showErrors(errors) {
    for (const input of reviewInputFields) {
      if (errors[input]) {
        document.getElementById(`error_review_${input}`).textContent =
          errors[input];
      } else {
        document.getElementById(`error_review_${input}`).textContent = '';
      }
    }
  }
}
