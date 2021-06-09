import MapInfoWindow from './map_info_window';
import MapPopup from './map_popup';

// normal marker
const ICON_PATH =
  'M32 2a20 20 0 0 0-20 20c0 18 20 40 20 40s20-22 20-40A20 20 0 0 0 32 2z';

// more wider marker
const ICON_TWO_PATH =
  'M55.9 28.3c.1-.8.1-1.5.1-2.3a24 24 0 1 0-48 0c0 .8 0 1.6.1 2.3v.3C10.1 47.6 32 62 32 62s21.9-14.6 23.8-33.3z';

// circle on pole
const ICON_THREE_PATH =
  'M32 2a20 20 0 0 0-20 20c0 18 20 40 20 40s20-22 20-40A20 20 0 0 0 32 2z';

const icon = ({ color = 'white', multiple = false }) => ({
  url: 'https://www.findmydirectdoctor.com/icon_yellow.svg',
  // fillColor: color,
  scaledSize: new google.maps.Size(44, 44),
  // scale: 0.5,
  // fillOpacity: 0.9,
  // strokeColor: 'grey',
  // strokeWidth: 3,
  // anchor: { x: 33, y: 62 },
  // labelOrigin: { x: 30, y: 30 },
});

const icon2 = ({ color = 'white', multiple = false }) => ({
  url: 'https://www.findmydirectdoctor.com/icon_gray.svg',
  // fillColor: color,
  scaledSize: new google.maps.Size(44, 44),
  // scale: 0.5,
  // fillOpacity: 0.9,
  // strokeColor: 'grey',
  // strokeWidth: 3,
  // anchor: { x: 33, y: 62 },
  // labelOrigin: { x: 30, y: 30 },
});
export const customIcon = icon;
export const customIcon2 = icon2;

export default class MapPinGenerator {
  constructor(pinsData = ['']) {
    this.pinData = pinsData;
  }

  pricePins() {
    return this.pinData.map((a) => {
      const coord = a.split(',');
      return {
        lat: coord[0],
        lng: coord[1],
        content: this.popup(coord[2] || 'no price', { ids: [coord[3]] }),
        click: (overlay) => {
          const popup = new MapPopup(overlay.el, { data: coord });
          popup.show();
        },
      };
    });
  }

  groupedMarkers(skipInfoWindow = false) {
    const groups = this.groupData();
    return Object.keys(groups).map((key) => {
      const { count, lat, lng, ids } = groups[key];
      const width = count > 1 ? '300px' : '200px';
      return {
        lat,
        lng,
        icon: icon2({ multiple: count > 1 }),
        // label: count > 1 ? count.toString() : '1',
        label: {
          text: count > 1 ? count.toString() : '1',
          color: '#fff',
          fontSize: '18px',
        },
        ids: ids,
        infoWindow: skipInfoWindow
          ? ''
          : new MapInfoWindow(ids).content({
              maxWidth: width,
              minWidth: width,
            }),
      };
    });
  }

  groupedPins() {
    const groups = this.groupData();
    return Object.keys(groups).map((key) => {
      const { count, lat, lng, ids } = groups[key];
      const data = [lat, lng, '0', ids.join('-')];
      const variant = 'pin';
      return {
        lat,
        lng,
        content: this.popup(count > 1 ? count : '', { ids, variant }),
        click: (overlay) => {
          const popup = new MapPopup(overlay.el, { data, ids, variant });
          popup.show();
        },
      };
    });
  }

  groupData() {
    const groups = {};
    this.pinData.forEach((a) => {
      const coord = a.split(',');
      const key = `${coord[0].trim()}${coord[1].trim()}`;
      const content = groups[key] || {
        count: 0,
        lat: coord[0],
        lng: coord[1],
        ids: [],
      };
      content.count += 1;
      content.ids.push(coord[3]);
      groups[key] = content;
    });
    return groups;
  }

  data() {
    return this.pinData.map((a) => {
      const coord = a.split(',');
      return {
        lat: coord[0],
        lng: coord[1],
        id: coord[3],
      };
    });
  }

  popup(content, { ids = [], variant = 'popup' }) {
    const classes = ids.map((a) => `doc-${a}-popup`).join(' ');
    const id = ids.join('-');
    return `<div class="${variant}-container ${classes}" id="doc-${id}-popup" tab-index="1">
      <div class="${variant}-bubble-anchor">
        <div class="${variant}-bubble">${content}</div>
      </div>
    </div>`;
  }
}
