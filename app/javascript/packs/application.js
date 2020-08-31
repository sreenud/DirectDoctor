import 'controllers';
import $ from 'jquery';

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

window.jQuery = $;
window.$ = $;
