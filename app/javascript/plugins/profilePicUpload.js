import {
  Core,
  FileInput,
  Informer,
  ProgressBar,
  ThumbnailGenerator,
  XHRUpload,
} from 'uppy';
import cropbox from './cropbox';

function profilePicUpload(fileInput) {
  const hiddenInput = document.querySelector('.upload-data');
  const imagePreview = document.querySelector('.upload-preview img');
  const formGroup = fileInput.parentNode;

  // remove our file input in favour of Uppy's
  formGroup.removeChild(fileInput);

  const uppy = Core({
    autoProceed: true,
  })
    .use(FileInput, {
      target: formGroup,
    })
    .use(Informer, {
      target: formGroup,
    })
    .use(ProgressBar, {
      target: imagePreview.parentNode,
    })
    .use(ThumbnailGenerator, {
      thumbnailHeight: 600,
    })
    .use(XHRUpload, {
      endpoint: '/images/upload', // path to the upload endpoint
    });

  uppy.on('thumbnail:generated', (file, preview) => {
    // show image preview while the file is being uploaded
    imagePreview.src = preview;
  });

  uppy.on('upload-success', (file, response) => {
    // retrieve uploaded file data
    const uploadedFileData = response.body.data;

    // set hidden field value to the uploaded file data so that it's submitted
    // with the form as the attachment
    hiddenInput.value = JSON.stringify(uploadedFileData);
    cropbox(imagePreview, response.uploadURL, {
      onCrop(detail) {
        const fileData = JSON.parse(hiddenInput.value);
        fileData.metadata.crop = detail;
        hiddenInput.value = JSON.stringify(fileData);
      },
    });
  });
}

export default profilePicUpload;
