import { Controller } from 'stimulus';

export default class FilterController extends Controller {
  static targets = ['rating', 'experience', 'speciality'];
}
