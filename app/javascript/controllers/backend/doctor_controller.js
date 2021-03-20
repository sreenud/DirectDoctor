/* eslint-disable prefer-destructuring */
/* eslint-disable no-param-reassign */
/* eslint-disable no-unused-expressions */
import { Controller } from 'stimulus';
import Choices from 'choices.js';
import Tagify from '@yaireo/tagify';

export default class extends Controller {
  static targets = [
    'errors',
    'minExperience',
    'maxExperience',
    'minPatients',
    'maxPatients',
    'minPrice',
    'maxPrice',
    'otherPriceInput',
    'otherPatientsInput',
    'disciplinaryAction',
    'disciplinaryActionInput',
    'profileImage',
    'doctorId',
    'imageUrl',
  ];

  connect() {
    const primarySpeciality = new Choices('#doctor_speciality_id', {
      removeItemButton: true,
      addItems: false,
    });

    const otherSpeciality = new Choices('#doctor_other_specialities', {
      addItems: true,
      removeItemButton: true,
    });

    const states = new Choices('#doctor_active_licenses', {
      addItems: true,
      removeItemButton: true,
    });

    const input = document.querySelector('input[name="doctor[access]"]');
    const access = new Tagify(input, {
      mode: 'select',
      whitelist: ['Yes', 'No', 'Not available'],
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
        'Not available',
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
      whitelist: ['Yes', 'No', 'Not available'],
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
      whitelist: [
        '15 minutes',
        '30 minutes',
        '45 minutes',
        '1 hour',
        'Not available',
      ],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    this.doctorDegree();
    this.holistic();
    this.teleHealth();
    this.homeVisit();
    this.aditionalService();
    this.language();
    this.doctorNames();
  }

  doctorNames() {
    var that = this;
    const url = '/admin/data/doctor_names.json';
    const titleInput = document.querySelector('input[name="doctor[name]"]');
    const doctorName = new Tagify(titleInput, {
      whitelist: [],
      maxTags: 10,
      dropdown: {
        maxItems: 10, // <- mixumum allowed rendered suggestions
        classname: 'tags-look', // <- custom classname for this dropdown, so it could be targeted
        enabled: 0, // <- show suggestions on focus
        closeOnSelect: false, // <- do not hide the suggestions dropdown once an item has been selected
      },
    });

    doctorName.on('input', function (e) {
      that.loadWhiteList(e, doctorName, url);
    });
  }

  doctorDegree() {
    var that = this;
    const url = '/admin/data/degree.json';
    const titleInput = document.querySelector('input[name="doctor[title]"]');
    const doctorTitle = new Tagify(titleInput, {
      whitelist: [],
      maxTags: 10,
      dropdown: {
        maxItems: 20, // <- mixumum allowed rendered suggestions
        classname: 'tags-look', // <- custom classname for this dropdown, so it could be targeted
        enabled: 0, // <- show suggestions on focus
        closeOnSelect: false, // <- do not hide the suggestions dropdown once an item has been selected
      },
    });

    doctorTitle.on('focus', function (e) {
      that.loadWhiteList(e, doctorTitle, url);
    });
  }

  holistic() {
    var that = this;
    const url = '/admin/data/holistic_medicine.json';
    const holisticInput = document.querySelector(
      'input[name="doctor[holistic_option]"]'
    );
    const holistic = new Tagify(holisticInput, {
      mode: 'select',
      whitelist: [],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    holistic.on('focus', function (e) {
      that.loadWhiteList(e, holistic, url);
    });
  }

  teleHealth() {
    var that = this;
    const url = '/admin/data/holistic_medicine.json';
    const teleHealthInput = document.querySelector(
      'input[name="doctor[telehealth_option]"]'
    );
    const teleHealth = new Tagify(teleHealthInput, {
      mode: 'select',
      whitelist: [],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    teleHealth.on('focus', function (e) {
      that.loadWhiteList(e, teleHealth, url);
    });
  }

  homeVisit() {
    var that = this;
    const url = '/admin/data/holistic_medicine.json';
    const homeVisitInput = document.querySelector(
      'input[name="doctor[home_visit_option]"]'
    );
    const homeVisit = new Tagify(homeVisitInput, {
      mode: 'select',
      whitelist: [],
      keepInvalidTags: true, // do not auto-remove invalid tags
      dropdown: {
        // closeOnSelect: false
      },
    });

    homeVisit.on('focus', function (e) {
      that.loadWhiteList(e, homeVisit, url);
    });
  }

  aditionalService() {
    var that = this;
    const url = '/admin/data/services.json';
    const aditionalServiceInput = document.querySelector(
      'input[name="doctor[aditional_services]"]'
    );
    // init Tagify script on the above inputs
    const aditionalService = new Tagify(aditionalServiceInput, {
      whitelist: [],
      maxTags: 10,
      dropdown: {
        maxItems: 20, // <- mixumum allowed rendered suggestions
        classname: 'tags-look', // <- custom classname for this dropdown, so it could be targeted
        enabled: 0, // <- show suggestions on focus
        closeOnSelect: false, // <- do not hide the suggestions dropdown once an item has been selected
      },
    });

    aditionalService.on('focus', function (e) {
      that.loadWhiteList(e, aditionalService, url);
    });
  }

  language() {
    var that = this;
    const url = '/admin/data/languages.json';
    const languageInput = document.querySelector(
      'input[name="doctor[language]"]'
    );
    // init Tagify script on the above inputs
    const language = new Tagify(languageInput, {
      whitelist: [],
      maxTags: 10,
      dropdown: {
        maxItems: 20, // <- mixumum allowed rendered suggestions
        classname: 'tags-look', // <- custom classname for this dropdown, so it could be targeted
        enabled: 0, // <- show suggestions on focus
        closeOnSelect: false, // <- do not hide the suggestions dropdown once an item has been selected
      },
    });

    language.on('focus', function (e) {
      that.loadWhiteList(e, language, url);
    });
  }

  loadWhiteList(e, doctorTitle, url) {
    let controller;
    const value = e.detail.value;
    doctorTitle.settings.whitelist.length = 0; // reset the whitelist

    controller && controller.abort();
    controller = new AbortController();

    doctorTitle.loading(true).dropdown.hide.call(doctorTitle);

    fetch(`${url}?value=${value}`, { signal: controller.signal })
      .then((RES) => RES.json())
      .then(function (whitelist) {
        doctorTitle.settings.whitelist.splice(
          0,
          whitelist.length,
          ...whitelist
        );
        doctorTitle.loading(false).dropdown.show.call(doctorTitle, value);
      });
  }

  experienceChange(event) {
    const select = event.target;
    const option = select[select.selectedIndex];
    this.minExperienceTarget.value = option.dataset.minExperience;
    this.maxExperienceTarget.value = option.dataset.maxExperience;
  }

  patientChange(event) {
    const select = event.target;
    const option = select[select.selectedIndex];
    this.minPatientsTarget.value = option.dataset.minPatients;
    this.maxPatientsTarget.value = option.dataset.maxPatients;
  }

  priceChange(event) {
    const select = event.target;
    const option = select[select.selectedIndex];
    this.minPriceTarget.value = option.dataset.minPrice;
    this.maxPriceTarget.value = option.dataset.maxPrice;
  }

  disciplinaryActionChange(event) {
    this.disciplinaryActionInput(this.disciplinaryActionTarget.value);
  }

  displayOtherPriceInput(display) {
    const otherPriceInput = this.otherPriceInputTarget;
    if (display == 'show') {
      otherPriceInput.classList.remove('hidden');
    } else {
      otherPriceInput.classList.add('hidden');
    }
  }

  displayOtherPatientsInput(display) {
    const otherPatientsInput = this.otherPatientsInputTarget;
    if (display == 'show') {
      otherPatientsInput.classList.remove('hidden');
    } else {
      otherPatientsInput.classList.add('hidden');
    }
  }

  disciplinaryActionInput(display) {
    const disciplinaryActionInput = this.disciplinaryActionInputTarget;
    if (display == 'Yes') {
      disciplinaryActionInput.classList.remove('hidden');
    } else {
      disciplinaryActionInput.classList.add('hidden');
    }
  }

  uploadImage() {
    const fileData = this.profileImageTarget.value;
    const doctorId = this.doctorIdTarget.value;

    const formData = new FormData();
    formData.append('doctor[image]', fileData);
    formData.append('id', doctorId);

    fetch('/admin/doctors/upload-image', {
      body: formData,
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token'),
      },
    })
      .then((response) => response.json())
      .then((result) => {
        document.getElementById('image-save-button').classList.add('hidden');
        const image = `<img src="${result.image_url}" height="300" class="rounded">`;
        this.imageUrlTarget.innerHTML = image;
      });
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute('content');
  }
}
