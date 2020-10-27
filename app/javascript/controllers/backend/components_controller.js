import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    'componentText',
    'componentLink',
    'components',
    'componentTemplate',
    'errors',
  ];

  addComponent(event) {
    event.preventDefault();
    const textCount = this.validateTargets(this.componentTextTargets);
    const linkCount = this.validateTargets(this.componentLinkTargets);
    if (textCount == 0 && linkCount == 0) {
      const content = this.componentTemplateTarget.innerHTML.replace(
        /NEW_INDEX/g,
        new Date().getTime()
      );
      this.componentsTarget.insertAdjacentHTML('beforeend', content);
    }
  }

  deleteComponent(event) {
    event.preventDefault();
    event.target.closest('div').remove();
  }

  validateTargets(targets) {
    let flag = 0;
    for (let i = 0; i < targets.length; i++) {
      if (!targets[i].value) {
        targets[i].classList.add('border-red-400');
        flag++;
      } else {
        targets[i].classList.remove('border-red-400');
      }
    }
    return flag;
  }
}
