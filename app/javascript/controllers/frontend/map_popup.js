export default class MapPopup {
  constructor(container, { data = [], ids = [], variant = 'popup' }) {
    this.variant = variant;
    this.container = container.querySelector(`.${variant}-container`);
    this.data = {
      lat: data[0],
      lng: data[1],
      id: data[3],
    };
    this.ids = ids;
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
    this.fetchDoctorData();
    infoWindow.appendChild(this.doctorPopup());
    this.container.appendChild(infoWindow);
    this.popup = infoWindow;
  }

  fetchDoctorData(id = this.data.id) {
    const card = document.querySelector(`#doc-${id}`);
    this.doctorData = {
      name: card.getAttribute('data-name'),
      rating: card.getAttribute('data-rating'),
      price: card.getAttribute('data-price'),
      image: card.getAttribute('data-image'),
      spcialty: card.getAttribute('data-spcialty'),
      clinicName: card.getAttribute('data-clinicname'),
    };
  }

  doctorPopup(data = this.doctorData) {
    const { name, rating, price, image, clinicName } = data;
    const cont = document.createElement('div');
    cont.classList.add('info-window-container');
    cont.innerHTML = `
      <img width="100%" height="12rem" src="${image}" />
      <p class="info-window-heading">${name}</p>
      <p class="info-window-price-range">${spcialty}</p>
      <p class="info-window-rating">${clinicName}</p>
    `;
    return cont;
  }
}
