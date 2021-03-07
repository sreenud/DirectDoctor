import { Controller } from 'stimulus';
import imageUploader from '../../custom/imageUploader';

export default class extends Controller {
  connect() {
    this.initImageUpload();
  }

  initImageUpload() {
    // document.querySelectorAll('.upload-file').forEach((fileInput) => {
    //   imageUploader(fileInput);
    // });

    document
      .querySelectorAll('input[type="file"]')
      .forEach(function (fileInput) {
        imageUploader(fileInput);
      });
  }
}
