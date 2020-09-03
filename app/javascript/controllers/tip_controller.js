/* eslint-disable no-new */
import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  static targets = ['output'];

  connect() {
    const tipTopicIds = new Choices('#tip_topic_ids', {
      removeItemButton: true,
    });

    const metaKeywords = new Choices('#tip_meta_keywords', {
      delimiter: ',',
      editItems: true,
      maxItemCount: 5,
      removeItemButton: true,
      duplicateItemsAllowed: false,
    });
  }
}
