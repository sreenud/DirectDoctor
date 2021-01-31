import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  connect() {
    const jobSpecialities = new Choices('#job_specialities', {
      removeItemButton: true,
      addItems: false,
    });
  }
}
