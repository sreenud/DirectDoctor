import 'controllers/frontend';
import 'alpinejs';

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
require('custom/glidejs_custom.js');

const images = require.context('../images', true);
/* eslint-disable no-unused-vars */
const imagePath = (name) => images(name, true);

window.initPlaces = function (...args) {
  const event = document.createEvent('Events');
  event.initEvent('google-maps-callback', true, true);
  event.args = args;
  window.dispatchEvent(event);
};
