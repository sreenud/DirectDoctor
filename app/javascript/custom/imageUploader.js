/* eslint-disable dot-notation */
/* eslint-disable prefer-const */
import {
  Core,
  XHRUpload,
  FileInput,
  Informer,
  StatusBar,
  ThumbnailGenerator,
} from 'uppy';
import Cropper from 'cropperjs';

function imageUploader(fileInput) {
  var formGroup = fileInput.parentNode;
  var hiddenInput = document.querySelector('.upload-data');
  var imagePreview = document.querySelector('.image-preview img');

  formGroup.removeChild(fileInput);

  var uppy = Core({
    autoProceed: true,
    restrictions: {
      allowedFileTypes: fileInput.accept.split(','),
    },
  })
    .use(FileInput, {
      target: formGroup,
      locale: { strings: { chooseFiles: 'Choose file' } },
    })
    .use(Informer, {
      target: formGroup,
    })
    .use(StatusBar, {
      target: '.doctor-profile-tags .upload-progress',
      hideUploadButton: true,
      hideAfterFinish: false,
    })
    .use(ThumbnailGenerator, {
      thumbnailWidth: 600,
    })
    .use(XHRUpload, {
      endpoint: '/images/upload',
    });

  uppy.on('upload-success', function (file, response) {
    imagePreview.src = response.uploadURL;
    var uploadedFileData = JSON.stringify(response.body['data']);

    hiddenInput.value = uploadedFileData;
    var copper = new Cropper(imagePreview, {
      checkCrossOrigin: false,
      viewMode: 3,
      dragMode: 'none',
      aspectRatio: 14 / 16,
      autoCropArea: 0.65,
      restore: false,
      guides: false,
      center: false,
      highlight: false,
      cropBoxMovable: true,
      cropBoxResizable: false,
      toggleDragModeOnDblclick: false,
      zoomable: true,
      zoomOnTouch: true,
      zoomOnWheel: true,
      crop: function (event) {
        let data = JSON.parse(hiddenInput.value);
        data['metadata']['crop'] = event.detail;
        hiddenInput.value = JSON.stringify(data);
      },
    });
  });
}

export default imageUploader;
