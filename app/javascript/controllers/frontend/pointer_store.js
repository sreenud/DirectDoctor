import MapInfoWindow from './map_info_window';
import MapPinGenerator, { customIcon } from './map_pin_generator';

export default class PointerStore {
  constructor(map, pins = []) {
    this.maps = map;
    this.pointerData = pins;
    this.pinIndex = {}; // store lat,lng:  {ids: [ids], index, instance}
    window.google.maps.event.addListener(this.maps.map, 'click', () => {
      if (this.infoWindow) {
        this.infoWindow.close();
      }
    });
  }

  pinData(data = this.pointerData) {
    return new MapPinGenerator(data || []).groupedMarkers();
  }

  createPins() {
    this.pinData().forEach((pin, i) => {
      const { ids, lat, lng, icon, label, infoWindow } = pin;
      const marker = this.maps.addMarker({ lat, lng, icon, label, infoWindow });
      this.setEvents(ids, marker);
      this.setMarkerEvents(marker, ids.length > 1);
      const index = `${lat.trim()}${lng.trim()}`;
      this.pinIndex[index] = {
        instance: marker,
        index: i,
        ids,
        infoWindow,
      };
    });
  }

  setEvents(ids, marker) {
    const multiple = ids.length > 1;
    ids.forEach((id) => {
      const card = document.querySelector(`#doc-${id}`);
      if (card !== undefined && card !== null) {
        card.addEventListener('mouseenter', () => {
          marker.setIcon(customIcon({ color: '#e7ab00', multiple }));
        });
        card.addEventListener('mouseleave', () => {
          marker.setIcon(customIcon({ color: 'white', multiple }));
        });
      }
    });
  }

  setMarkerEvents(marker, multiple = false) {
    window.google.maps.event.addListener(marker, 'mouseover', () => {
      marker.setIcon(customIcon({ color: '#e7ab00', multiple }));
    });
    window.google.maps.event.addListener(marker, 'mouseout', () => {
      marker.setIcon(customIcon({ color: 'white', multiple }));
    });
    window.google.maps.event.addListener(marker, 'click', () => {
      this.infoWindow = marker.infoWindow;
    });
  }

  append(pins = []) {
    const points = new MapPinGenerator(pins).data();
    const unborn = [];
    points.forEach((a, index) => {
      const key = `${a.lat.trim()},${a.lng.trim()}`;
      if (this.pinIndex[key] !== undefined && this.pinIndex[key] !== null) {
        const indexedData = this.pinIndex[key] || { ids: [] };
        if (!indexedData.ids.includes(id)) {
          const ids = [...indexedData.ids, id];
          indexedData.instace.setMap(null);
          const ins = this.maps.addMarker({
            lat,
            lng,
            icon: customIcon({ multiple: ids.length > 1 }),
            label: ids.length > 1 ? ids.length.toString : '',
            infoWindow: {
              content: new MapInfoWindow(ids).appendData(
                indexedData.infoWindow.content,
                id
              ),
            },
          });
        }
      } else {
        unborn.push(pins[index]);
      }
    });
  }
}
