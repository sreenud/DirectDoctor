/* eslint-disable no-new */
import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  static targets = ['output'];

  connect() {
    const category = new Choices('#topic_category_id');
  }
}
