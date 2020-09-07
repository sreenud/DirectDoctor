import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  connect() {
    const userRoles = new Choices('#user_role_ids', {
      removeItemButton: true,
    });
  }
}
