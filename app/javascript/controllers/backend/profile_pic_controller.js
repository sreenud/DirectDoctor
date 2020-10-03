import { Controller } from 'stimulus';
import profilePicUpload from '../../plugins/profilePicUpload';

export default class extends Controller {
  connect() {
    this.initProfilePicUpload();
  }

  initProfilePicUpload() {
    document.querySelectorAll('.upload-file').forEach((fileInput) => {
      profilePicUpload(fileInput);
    });
  }
}
