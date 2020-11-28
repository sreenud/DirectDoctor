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

  singleWindow(id = this.ids[0]) {
    const ele = document.querySelector(`#doc-${id}`);
    const data = {
      name: ele.getAttribute('data-name'),
      rating: ele.getAttribute('data-rating'),
      price: ele.getAttribute('data-price'),
      image: ele.getAttribute('data-image'),
    };
    const win = document.createElement('div');
    win.classList.add('popup-info-window', 'marker-edition');
    const cont = document.createElement('div');
    cont.classList.add('info-window-container');
    cont.innerHTML = `
      <img src="${data.image}" />
      <p class="info-window-heading">${data.name}</p>
      <p class="info-window-price-range">${data.price}</p>
      <p class="info-window-rating">${data.rating}</p>
    `;
    win.appendChild(cont);
    return win;
  }

  groupedWindow() {
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

    const itemSize = 250;

    const maxScroll = this.ids.length * 250;

    arrowRight.onclick = () => {
      const currentScroll = content.scrollLeft;
      content.scrollLeft = (currentScroll + itemSize) % maxScroll;
    };

    arrowLeft.onclick = () => {
      const currentScroll = content.scrollLeft;
      content.scrollLeft =
        maxScroll - ((currentScroll + itemSize) % (maxScroll + itemSize));
    };

    arrowLeft.append('⌫');
    arrowRight.append('⌦');
    container.appendChild(content);
    container.appendChild(buttons);
    buttons.appendChild(arrowLeft);
    buttons.appendChild(arrowRight);
    this.ids.forEach((id) => {
      const item = document.createElement('div');
      item.classList.add('info-window-carousel-item');
      item.appendChild(this.singleWindow(id));
      content.appendChild(item);
    });
    return container;
  }
}
