import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  connect() {
    const jobDoctors = new Choices('#job_doctor_id', {
      removeItemButton: true,
      addItems: false,
    });

    const jobSpecialities = new Choices('#job_specialities', {
      removeItemButton: true,
      addItems: false,
    });
  }
}
