/* eslint-disable no-new */
import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  static targets = ['output'];

  connect() {
    const tipTopicIds = new Choices('#tip_topic_id', {
      removeItemButton: true,
    });

    const tagsList = new Choices('#tip_related_topics', {
      delimiter: ',',
      editItems: true,
      maxItemCount: 5,
      removeItemButton: true,
      duplicateItemsAllowed: false,
    });
  }
}
