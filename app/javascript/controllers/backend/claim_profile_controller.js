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

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute('content');
  }
}
