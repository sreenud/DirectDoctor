import { Controller } from 'stimulus';
import { ajax } from 'jquery';
import ParamRedirect, {
  AddHoverHighlight,
  locationParams,
  ParamUrl,
  setLocationString,
  URIPush,
} from './param_redirect';
import MapPinGenerator, { customIcon } from './map_pin_generator';

const { GMaps } = window;

export default class extends Controller {
  connect() {
    this.infoWindow = null;

    this.maps = new GMaps({
      div: '#job_map',
      lat: '40.730610',
      lng: '-73.935242',
      zoom: 4,
      fullscreenControl: false,
      dragend: (e) => {
        const { center } = e;
        const lat = center.lat();
        const lng = center.lng();
        this.getResults({ lat, lng });
      },
    });
  }
}
