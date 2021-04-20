import { Controller } from 'stimulus';
import Swal from 'sweetalert2';

export default class extends Controller {
  static values = {
    url: String,
  };

  delete() {
    Swal.fire({
      heightAuto: false,
      title: 'Are you sure?',
      text:
        'Confirming this will permanently delete your profile and any associated profile information',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!',
    }).then((result) => {
      if (result.isConfirmed) {
        fetch(this.urlValue)
          .then((response) => response.text())
          .then((data) => {
            const responseData = JSON.parse(data);
            if (responseData.success == true) {
              Swal.fire('Deleted', 'Your account has been deleted.', 'success');
            }
          });
      }
    });
  }
}
