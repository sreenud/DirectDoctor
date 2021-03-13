/* eslint-disable no-param-reassign */
/* eslint-disable new-cap */
/* eslint-disable no-shadow */
/* eslint-disable dot-notation */
/* eslint-disable no-restricted-syntax */
import { Controller } from 'stimulus';
import autoComplete from '@tarekraafat/autocomplete.js';

const onboardingInputFields = ['profile_name', 'document'];
export default class extends Controller {
  static targets = [
    'userType',
    'submitButton',
    'doctorForm',
    'fileName',
    'fileOriginalName',
    'fileErrorMessage',
  ];

  connect() {
    // The autoComplete.js Engine instance creator
    const autoCompleteJS = new autoComplete({
      name: 'Doctor names',
      data: {
        src: async function () {
          // Loading placeholder text
          document
            .querySelector('#autoComplete')
            .setAttribute('placeholder', 'Loading...');
          // Fetch External Data Source
          const source = await fetch('/data/doctor_names.json');
          const data = await source.json();
          // Post Loading placeholder text
          document
            .querySelector('#autoComplete')
            .setAttribute('placeholder', autoCompleteJS.placeHolder);
          // Returns Fetched data
          return data;
        },
        key: ['name'],
        results: (list) => {
          // Filter duplicates
          const filteredResults = Array.from(
            new Set(list.map((value) => value.match))
          ).map((food) => {
            return list.find((value) => value.match === food);
          });

          return filteredResults;
        },
      },
      trigger: {
        event: ['input', 'focus'],
      },
      placeHolder: 'Search for your profile!',
      searchEngine: 'strict',
      highlight: true,
      maxResults: 5,
      resultItem: {
        content: (data, element) => {
          // Prepare Value's Key
          const key = Object.keys(data.value).find(
            (key) => data.value[key] === element.innerText
          );
          // Modify Results Item
          element.style = 'display: flex; justify-content: space-between;';
          element.innerHTML = `<span style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
            ${element.innerHTML}</span>
            <span style="display: flex; align-items: center; font-size: 13px; font-weight: 100; text-transform: uppercase; color: rgba(0,0,0,.2);">
          ${key}</span>`;
        },
      },
      noResults: (dataFeedback, generateList) => {
        // Generate autoComplete List
        generateList(autoCompleteJS, dataFeedback, dataFeedback.results);
        // No Results List Item
        const result = document.createElement('li');
        result.setAttribute('class', 'no_result');
        result.setAttribute('tabindex', '1');
        result.innerHTML = `<span style="display: flex; align-items: center; font-weight: 100; color: rgba(0,0,0,.2);">Found No Results for "${dataFeedback.query}"</span>`;
        document
          .querySelector(`#${autoCompleteJS.resultsList.idName}`)
          .appendChild(result);
      },
      onSelection: (feedback) => {
        // document.querySelector('#autoComplete').blur();
        // Prepare User's Selected Value
        const selection = feedback.selection.value[feedback.selection.key];
        // Render selected choice to selection div
        // Replace Input value with the selected value
        document.querySelector('#autoComplete').value = selection;
        // Console log autoComplete data feedback
        console.log(feedback);
      },
    });
  }

  userChoice(event) {
    this.userTypeTargets.forEach((el, i) => {
      if (event.target == el) {
        console.log(event.target.value);
        if (event.target.value == 'doctor') {
          this.doctorFormTarget.classList.remove('hidden');
        } else {
          document.querySelector('#autoComplete').value = '';
          this.doctorFormTarget.classList.add('hidden');
        }
      }
    });
    this.submitButtonTarget.classList.remove('hidden');
  }

  fileDisplayName(event) {
    const fileName = event.target.value.split('\\').pop();
    this.fileOriginalNameTarget.innerHTML = fileName;
    this.fileErrorMessageTarget.innerHTML = '';
  }

  success(event) {
    const [data, status, xhr] = event.detail;
    this.successTarget.innerHTML = xhr.response;
    this.errorsTarget.innerHTML = '';
  }

  errorHandler(event) {
    const [data, status, xhr] = event.detail;
    const errors = JSON.parse(xhr.response);

    console.log(errors['messages']);
    this.showErrors(errors['messages'] || {});
    // this.errorsTarget.innerHTML = xhr.response;
  }

  showErrors(errors) {
    for (const input of onboardingInputFields) {
      console.log(input);
      if (errors[input]) {
        document.getElementById(`error_${input}`).textContent = errors[input];
      } else {
        document.getElementById(`error_${input}`).textContent = '';
      }
    }
  }
}
