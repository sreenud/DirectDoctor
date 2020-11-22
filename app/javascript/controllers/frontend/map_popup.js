export default class MapPopup {
  constructor(container, data) {
    this.container = container;
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
    infoWindow.classList.add('popup-info-window');
    infoWindow.innerHTML = this.data.id;
    this.container.appendChild(infoWindow);
    this.popup = infoWindow;
  }
}
