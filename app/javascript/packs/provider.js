import 'controllers/provider';
import 'alpinejs';

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

const images = require.context('../images', true);
/* eslint-disable no-unused-vars */
const imagePath = (name) => images(name, true);
