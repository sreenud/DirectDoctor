/* eslint-disable no-param-reassign */
import 'cropperjs/dist/cropper.css';

import Cropper from 'cropperjs';

function cropbox(image, url, { onCrop }) {
  // image.src = url;
  image = document.querySelector('#profile_image');
  var cropper = Cropper(image, {
    aspectRatio: 1,
    viewMode: 1,
    guides: false,
    autoCropArea: 1.0,
    background: false,
    zoomable: false,
    crop: (event) => onCrop(event.detail),
  });
}

export default cropbox;
