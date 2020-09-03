/* eslint-disable import/no-webpack-loader-syntax */
/* purgecss start ignore */

import { Controller } from 'stimulus';
import { connect } from 'tls';

import tinymce from 'tinymce/tinymce';
import 'tinymce/themes/silver';
import 'tinymce/icons/default';

import 'tinymce/plugins/table';
import 'tinymce/plugins/lists';
import 'tinymce/plugins/image';
import 'tinymce/plugins/media';
import 'tinymce/plugins/advlist';
import 'tinymce/plugins/link';
import 'tinymce/plugins/code';
import 'tinymce/plugins/pagebreak';
import 'tinymce/plugins/imagetools';
import 'tinymce/plugins/fullscreen';

import '!style-loader!css-loader!tinymce/skins/ui/oxide/skin.min.css';
import contentStyle from 'tinymce/skins/ui/oxide/content.min.css';
/* purgecss end ignore */

export default class TinymceController extends Controller {
  static targets = ['editorId'];

  editorId = '';

  connect() {
    tinymce.remove();

    const myToolbar =
      'undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | image media link | fullscreen code |';
    tinymce.init({
      theme: 'silver',
      skin: false,
      content_style: contentStyle.toString(),
      selector: `textarea.tinymce${this.editorId}`,
      convert_urls: false,

      plugins: [
        'table',
        'lists',
        'image',
        'media',
        'advlist',
        'link',
        'code',
        'imagetools',
        'fullscreen',
        'code',
      ],
      toolbar: myToolbar,
      rel_list: [
        { title: 'No-Follow', value: 'nofollow' },
        { title: 'Follow', value: 'follow' },
      ],
      font_formats:
        'Andale Mono=andale mono,times; Arial=arial,helvetica,sans-serif; Arial Black=arial black,avant garde; Book Antiqua=book antiqua,palatino; Comic Sans MS=comic sans ms,sans-serif; Courier New=courier new,courier; Georgia=georgia,palatino; Helvetica=helvetica; Impact=impact,chicago; Open sans=Open Sans, sans-serif; Symbol=symbol; Tahoma=tahoma,arial,helvetica,sans-serif; Terminal=terminal,monaco; Times New Roman=times new roman,times; Trebuchet MS=trebuchet ms,geneva; Verdana=verdana,geneva; Webdings=webdings; Wingdings=wingdings,zapf dingbats;',
      image_advtab: true,
      relative_urls: false,
      contextmenu: 'file edit view insert format tools table',
      images_upload_url: '/admin/media_storages',
      images_upload_handler: function (blobInfo, success, failure) {
        var xhr;
        var formData;
        xhr = new XMLHttpRequest();
        xhr.withCredentials = false;
        xhr.open('POST', '/admin/media_storages');

        xhr.onload = function () {
          var json;
          if (xhr.status != 201) {
            failure(`HTTP Error: ${xhr.status}`);
            return;
          }
          json = JSON.parse(xhr.responseText);
          if (!json) {
            failure(`Invalid JSON: ${xhr.responseText}`);
            return;
          }
          success(json.url);
        };

        formData = new FormData();
        formData.append('attachment', blobInfo.blob(), blobInfo.filename());
        xhr.setRequestHeader('X-CSRF-Token', getMetaValue('csrf-token'));
        xhr.send(formData);

        function getMetaValue(name) {
          const element = document.head.querySelector(`meta[name="${name}"]`);
          return element.getAttribute('content');
        }
      },
    });
  }
}
