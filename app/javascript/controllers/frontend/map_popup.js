export default class MapPopup {
  constructor(container, data) {
    this.container = container.querySelector('.popup-container');
    this.data = {
      lat: data[0],
      lng: data[1],
      id: data[3],
    };
  }

  show() {
    this.popup = this.container.querySelector('.popup-info-window');
    if (!this.popup) {
      this.build();
    }
    const current = document.querySelector('.popup-info-window.show');
    if (current !== undefined && current !== null) {
      current.classList.remove('show');
    }
    this.popup.classList.add('show');
  }

  build() {
    const infoWindow = document.createElement('div');
    infoWindow.setAttribute('tab-index', this.data.id);
    infoWindow.classList.add('popup-info-window');
    infoWindow.appendChild(this.doctorPopup());
    this.container.appendChild(infoWindow);
    this.popup = infoWindow;
  }

  fetchDoctorData() {
    const card = document.querySelector(`#doc-${this.data.id}`);
    this.doctorData = {
      name: card.getAttribute('data-name'),
      rating: card.getAttribute('data-rating'),
      price: card.getAttribute('data-price'),
      image: card.getAttribute('data-image'),
    };
  }

  doctorPopup() {
    this.fetchDoctorData();
    const { name, rating, price, image } = this.doctorData;
    const cont = document.createElement('div');
    cont.classList.add('info-window-container');
    cont.innerHTML = `
      <img src="${image}" />
      <p class="info-window-heading">${name}</p>
      <p class="info-window-price-range">${price}</p>
      <p class="info-window-rating">${rating}</p>
    `;
    return cont;
  }
}
