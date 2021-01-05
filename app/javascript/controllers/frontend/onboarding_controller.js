/* eslint-disable no-param-reassign */
import { Controller } from 'stimulus';
import Tagify from '@yaireo/tagify';

export default class extends Controller {
  static targets = ['userType', 'submitButton'];

  connect() {
    this.findMyProfileInfo();
  }

  findMyProfileInfo() {
    var that = this;
    const url = '/admin/data/doctor_names.json';
    const titleInput = document.querySelector('input[name=users-list-tags]');

    // initialize Tagify on the above input node reference
    const findMyProfile = new Tagify(titleInput, {
      tagTextProp: 'name', // very important since a custom template is used with this property as text
      enforceWhitelist: true,
      skipInvalid: true, // do not remporarily add invalid tags
      dropdown: {
        closeOnSelect: false,
        enabled: 0,
        classname: 'users-list',
        searchKeys: ['name', 'email'], // very important to set by which keys to search for suggesttions when typing
      },
      templates: {
        tag: tagTemplate,
        dropdownItem: suggestionItemTemplate,
      },
      whitelist: [
        {
          value: 1,
          name: 'Justinian Hattersley',
          avatar: 'https://i.pravatar.cc/80?img=1',
          email: 'jhattersley0@ucsd.edu',
        },
        {
          value: 2,
          name: 'Antons Esson',
          avatar: 'https://i.pravatar.cc/80?img=2',
          email: 'aesson1@ning.com',
        },
        {
          value: 3,
          name: 'Ardeen Batisse',
          avatar: 'https://i.pravatar.cc/80?img=3',
          email: 'abatisse2@nih.gov',
        },
        {
          value: 4,
          name: 'Graeme Yellowley',
          avatar: 'https://i.pravatar.cc/80?img=4',
          email: 'gyellowley3@behance.net',
        },
        {
          value: 5,
          name: 'Dido Wilford',
          avatar: 'https://i.pravatar.cc/80?img=5',
          email: 'dwilford4@jugem.jp',
        },
        {
          value: 6,
          name: 'Celesta Orwin',
          avatar: 'https://i.pravatar.cc/80?img=6',
          email: 'corwin5@meetup.com',
        },
        {
          value: 7,
          name: 'Sally Main',
          avatar: 'https://i.pravatar.cc/80?img=7',
          email: 'smain6@techcrunch.com',
        },
        {
          value: 8,
          name: 'Grethel Haysman',
          avatar: 'https://i.pravatar.cc/80?img=8',
          email: 'ghaysman7@mashable.com',
        },
        {
          value: 9,
          name: 'Marvin Mandrake',
          avatar: 'https://i.pravatar.cc/80?img=9',
          email: 'mmandrake8@sourceforge.net',
        },
        {
          value: 10,
          name: 'Corrie Tidey',
          avatar: 'https://i.pravatar.cc/80?img=10',
          email: 'ctidey9@youtube.com',
        },
        {
          value: 11,
          name: 'foo',
          avatar: 'https://i.pravatar.cc/80?img=11',
          email: 'foo@bar.com',
        },
        {
          value: 12,
          name: 'foo',
          avatar: 'https://i.pravatar.cc/80?img=12',
          email: 'foo.aaa@foo.com',
        },
      ],
    });
  }

  userChoice(event) {
    this.userTypeTargets.forEach((el, i) => {
      if (event.target == el) {
        console.log(event.target.value);
      }
    });
    this.submitButtonTarget.classList.remove('hidden');
  }
}

function tagTemplate(tagData) {
  return `${tagData.name}`;
}

function suggestionItemTemplate(tagData) {
  return `${
    tagData.avatar
      ? `
            `
      : ''
  }
            ${tagData.name}
            ${tagData.email}`;
}
