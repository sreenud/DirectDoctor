/* eslint-disable no-restricted-syntax */
/* eslint-disable no-prototype-builtins */
/* eslint-disable prefer-destructuring */

import { Controller } from 'stimulus';

export default class extends Controller {
  initialize() {
    this.smoothScroll();
    this.scrollToPosition();
  }

  smoothScroll() {
    const tabs = document.querySelectorAll('.tab-scroll');
    for (const t in tabs) {
      if (tabs.hasOwnProperty(t)) {
        tabs[t].addEventListener('click', (e) => {
          e.preventDefault();
          document.querySelector(tabs[t].hash).scrollIntoView({
            behavior: 'smooth',
          });
        });
      }
    }
  }

  scrollToPosition() {
    const sections = document.querySelectorAll('.section-position');
    window.onscroll = () => {
      const scrollPosition =
        (document.documentElement.scrollTop || document.body.scrollTop) + 100;

      for (const s in sections) {
        if (
          sections.hasOwnProperty(s) &&
          sections[s].offsetTop <= scrollPosition
        ) {
          const id = sections[s].id;
          document
            .querySelector('.tab.tab-active')
            .classList.remove('tab-active');

          document
            .querySelector(`a[href*=${id}]`)
            .parentNode.classList.add('tab-active');
        }
      }
    };
  }
}
