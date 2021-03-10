import { Controller } from 'stimulus';

export default class extends Controller {
  claimProfile() {
    const formData = new FormData();
    formData.append('doctor_id', this.data.get('doctorId'));
    formData.append('user_id', this.data.get('userId'));

    fetch(`/admin/claim_profiles/${this.data.get('id')}`, {
      body: formData,
      method: 'PATCH',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token'),
      },
    })
      .then((response) => response.text())
      .then((data) => {
        const responseData = JSON.parse(data);
        if (responseData.success == true) {
          window.location = responseData.url;
        }
      });
  }

  requestStatus(event) {
    this.userTypeTargets.forEach((el, i) => {
      if (event.target == el) {
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

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute('content');
  }
}
