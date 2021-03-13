/* eslint-disable dot-notation */
/* eslint-disable no-restricted-syntax */
import { Controller } from 'stimulus';

const claimProfileInputFields = ['claim_profile_comments_comment'];
export default class extends Controller {
  static targets = [
    'success',
    'error',
    'fileName',
    'fileOriginalName',
    'fileErrorMessage',
  ];

  success(event) {
    const [data, status, xhr] = event.detail;
    this.successTarget.innerHTML = data.message;
    this.errorsTarget.innerHTML = '';
  }

  errorHandler(event) {
    const [data, status, xhr] = event.detail;
    const errors = JSON.parse(xhr.response);

    this.showErrors(errors['messages'] || {});
    // this.errorsTarget.innerHTML = xhr.response;
  }

  showErrors(errors) {
    for (const input of claimProfileInputFields) {
      const inputMessage = input.replace(
        '_comments_comment',
        '_comments.comment'
      );
      if (errors[inputMessage]) {
        document.getElementById(
          `error_${input}`
        ).innerHTML = `Message ${errors[inputMessage][0]}`;
      } else {
        document.getElementById(`error_${input}`).innerHTML = '';
      }
    }
  }

  fileDisplayName(event) {
    const fileName = event.target.value.split('\\').pop();
    this.fileOriginalNameTarget.innerHTML = fileName;
    this.fileErrorMessageTarget.innerHTML = '';
  }

  messageBox(event) {
    document.getElementById(`error_claim_profile_comments_comment`).innerHTML =
      '';
  }
}
