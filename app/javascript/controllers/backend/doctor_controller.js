import { Controller } from 'stimulus';
import Choices from 'choices.js';
import Tagify from '@yaireo/tagify';

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

    const input = document.querySelector('input[name="doctor[access]"]');
    const access = new Tagify(input, {
      mode: 'select',
      whitelist: ['Yes', 'No'],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    const appointmentsInput = document.querySelector(
      'input[name="doctor[appointments]"]'
    );
    const appointments = new Tagify(appointmentsInput, {
      whitelist: [
        'Same day appointments',
        'Next day appointments',
        '2 - 3 day appointments',
      ],
      dropdown: {
        maxItems: 20, // <- mixumum allowed rendered suggestions
        enabled: 0, // <- show suggestions on focus
        closeOnSelect: false, // <- do not hide the suggestions dropdown once an item has been selected
      },
    });

    const consultationInput = document.querySelector(
      'input[name="doctor[consultation]"]'
    );
    const consultation = new Tagify(consultationInput, {
      mode: 'select',
      whitelist: ['Yes', 'No'],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    const timeInput = document.querySelector(
      'input[name="doctor[free_consultation_time]"]'
    );
    const freeConsultationTime = new Tagify(timeInput, {
      mode: 'select',
      whitelist: ['15 minutes', '30 minutes', '45 minutes', '1 hour'],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    const languageInput = document.querySelector(
      'input[name="doctor[language]"]'
    );
    // init Tagify script on the above inputs
    const language = new Tagify(languageInput, {
      whitelist: [
        'English',
        'Spanish',
        'Chinese - Mandarin',
        'Chinese - Cantonese',
        'Arabic',
        'French',
        'Korean',
        'Russian',
        'German',
        'Hindi',
        'Portuguese',
        'Italian',
        'Polish',
        'Urdu',
        'Hebrew',
        'Tagalog - Filipino',
        'Japanese',
        'Vietnamese',
      ],
      maxTags: 10,
      dropdown: {
        maxItems: 20, // <- mixumum allowed rendered suggestions
        classname: 'tags-look', // <- custom classname for this dropdown, so it could be targeted
        enabled: 0, // <- show suggestions on focus
        closeOnSelect: false, // <- do not hide the suggestions dropdown once an item has been selected
      },
    });
  }
}
