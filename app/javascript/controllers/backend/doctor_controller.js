import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  connect() {
    const userRoles = new Choices('#doctor_title', {
      removeItemButton: true,
      addItems: false,
    });
    const primarySpeciality = new Choices('#doctor_primary_speciality', {
      removeItemButton: true,
      addItems: false,
    });

    const otherSpeciality = new Choices('#doctor_other_specialities', {
      addItems: true,
      removeItemButton: true,
    });
  }
}
