import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['readFull', 'readMoreBackground', 'readMoreIcon'];

  readMore(event) {
    this.readFullTarget.removeAttribute('style');
    this.readMoreBackgroundTarget.removeAttribute('style');
    this.readMoreIconTarget.innerHTML =
      'Less <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-up" class="w-4 h-4 inline-block" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="padding-left: 5px;"><path fill="currentColor" d="M240.971 130.524l194.343 194.343c9.373 9.373 9.373 24.569 0 33.941l-22.667 22.667c-9.357 9.357-24.522 9.375-33.901.04L224 227.495 69.255 381.516c-9.379 9.335-24.544 9.317-33.901-.04l-22.667-22.667c-9.373-9.373-9.373-24.569 0-33.941L207.03 130.525c9.372-9.373 24.568-9.373 33.941-.001z"></path></svg>';
    this.readMoreIconTarget.setAttribute(
      'data-action',
      'click->doctor#readLess'
    );
  }

  readLess(event) {
    this.readFullTarget.setAttribute(
      'style',
      'max-height: 120px; position: relative; overflow: hidden;'
    );
    this.readMoreBackgroundTarget.setAttribute(
      'style',
      'position: absolute; bottom: 0px; left: 0px; width: 100%; padding: 30px 0px; background-image: linear-gradient(rgba(255, 255, 255, 0), white);'
    );
    this.readMoreIconTarget.innerHTML =
      'Read More <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-down" class="w-4 h-4 inline-block" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" style="padding-left: 5px;"><path fill="currentColor" d="M207.029 381.476L12.686 187.132c-9.373-9.373-9.373-24.569 0-33.941l22.667-22.667c9.357-9.357 24.522-9.375 33.901-.04L224 284.505l154.745-154.021c9.379-9.335 24.544-9.317 33.901.04l22.667 22.667c9.373 9.373 9.373 24.569 0 33.941L240.971 381.476c-9.373 9.372-24.569 9.372-33.942 0z"></path></svg>';
    this.readMoreIconTarget.setAttribute(
      'data-action',
      'click->doctor#readMore'
    );
  }
}
