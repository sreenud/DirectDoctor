export default class MapInfoWindow {
  constructor(ids = []) {
    this.grouped = ids.length > 1;
    this.ids = ids;
  }

  content({ maxWidth = '200px', minWidth = null }) {
    return {
      content: this.windowData(),
      minWidth,
      maxWidth,
    };
  }

  windowData() {
    if (this.grouped) {
      return this.groupedWindow();
    }
    return this.singleWindow();
  }

  appendData(oldInfoWindow, newIds = []) {
    const oldNode =
      typeof oldInfoWindow === 'object'
        ? oldInfoWindow
        : new DOMParser().parseFromString(oldInfoWindow);
    const needConversion =
      this.grouped && !oldNode.querySelector('.info-window-carousel');
    if (needConversion) {
      const {
        container,
        content,
        arrowLeft,
        arrowRight,
      } = this.createCarousel();
      this.setArrowEvents(arrowLeft, arrowRight, content);
      content.appendChild(oldNode);
      newIds.forEach((id) => {
        const item = document.createElement('div');
        item.classList.add('info-window-carousel-item');
        item.appendChild(this.singleWindow(id));
        content.appendChild(item);
      });
      return container;
    }
    const { container, content, arrowLeft, arrowRight } = this.extractNodes(
      oldNode
    );
    this.setArrowEvents(arrowLeft, arrowRight, content);
    newIds.forEach((id) => {
      const item = document.createElement('div');
      item.classList.add('info-window-carousel-item');
      item.appendChild(this.singleWindow(id));
      content.appendChild(item);
    });
    return container;
  }

  singleWindow(id = this.ids[0]) {
    const ele = document.querySelector(`#doc-${id}`);
    const data = {
      name: ele.getAttribute('data-name'),
      rating: ele.getAttribute('data-rating'),
      price: ele.getAttribute('data-price'),
      image: ele.getAttribute('data-image'),
      spcialty: ele.getAttribute('data-spcialty'),
      clinicName: ele.getAttribute('data-clinicname'),
    };
    const win = document.createElement('div');
    win.classList.add('popup-info-window', 'marker-edition');
    const cont = document.createElement('div');
    cont.classList.add('info-window-container');
    cont.innerHTML = `
      <img src="${data.image}" />
      <p class="info-window-heading">${data.name}</p>
      <p class="info-window-price-range">${data.spcialty}</p>
      <p class="info-window-rating">${data.clinicName}</p>
    `;
    win.appendChild(cont);
    return win;
  }

  groupedWindow() {
    const { container, content, arrowLeft, arrowRight } = this.createCarousel();
    this.setArrowEvents(arrowLeft, arrowRight, content);
    this.ids.forEach((id) => {
      const item = document.createElement('div');
      item.classList.add('info-window-carousel-item');
      item.appendChild(this.singleWindow(id));
      content.appendChild(item);
    });
    return container;
  }

  /* eslint no-param-reassign: ["error", { "props": false }] */
  setArrowEvents(
    arrowLeft = document.createElement('button'),
    arrowRight,
    content = document.createElement('div')
  ) {
    const itemSize = 250;
    const maxScroll = this.ids.length * 250;

    arrowRight.addEventListener('click', () => {
      const currentScroll = content.scrollLeft;
      content.scrollLeft = (currentScroll + itemSize) % maxScroll;
    });

    arrowLeft.addEventListener('click', () => {
      const currentScroll = content.scrollLeft;
      content.scrollLeft =
        maxScroll - ((currentScroll + itemSize) % (maxScroll + itemSize));
    });
  }

  createCarousel() {
    const container = document.createElement('div');
    const content = document.createElement('div');
    const buttons = document.createElement('div');
    const arrowLeft = document.createElement('button');
    const arrowRight = document.createElement('button');

    container.classList.add('info-window-carousel');
    content.classList.add('info-window-carousel-content');
    buttons.classList.add('info-window-carousel-buttons');
    arrowLeft.classList.add('info-window-carousel-button');
    arrowRight.classList.add('info-window-carousel-button');
    arrowLeft.append('⌫');
    arrowRight.append('⌦');
    container.appendChild(content);
    container.appendChild(buttons);
    buttons.appendChild(arrowLeft);
    buttons.appendChild(arrowRight);

    return { container, content, buttons, arrowLeft, arrowRight };
  }

  extractNodes(oldNode = document.createElement('div')) {
    const container = oldNode;
    const content =
      container.querySelector('.info-window-carousel-content') ||
      document.createElement('div');
    const buttons =
      container.querySelector('.info-window-carousel-buttons') ||
      document.createElement('div');
    const arrowLeft =
      buttons.querySelector('button') || document.createElement('button');
    const arrowRight =
      buttons.querySelectorAll('button')[1] || document.createElement('button');

    return { container, content, buttons, arrowLeft, arrowRight };
  }
}
