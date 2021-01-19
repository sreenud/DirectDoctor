// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';
import TinymceController from '../backend/tinymce/tinymce_controller';
import ComponentsController from '../backend/components_controller';
import CredentialComponentsController from '../backend/credential_components_controller';
import MessageController from '../backend/message_controller';
import PlacesController from '../backend/places_controller';

const application = Application.start();
const context = require.context(
  'controllers/provider',
  true,
  /_controller\.js$/
);
application.load(definitionsFromContext(context));
application.register('tinymce', TinymceController);
application.register('components', ComponentsController);
application.register('credential-components', CredentialComponentsController);
application.register('message', MessageController);
application.register('places', PlacesController);
