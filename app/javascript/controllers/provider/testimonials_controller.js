import { Controller } from 'stimulus';
import Choices from 'choices.js';

export default class extends Controller {
  connect() {
    const testimonial = new Choices('#doctor_testimonials', {
      removeItemButton: true,
      addItems: false,
    });
  }
}
