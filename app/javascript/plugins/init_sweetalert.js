import Swal from 'sweetalert2';

const initSweetalert = () => {

const shareButton = document.querySelector('#share-button');
  if (shareButton) {
    shareButton.addEventListener("click", (event) => {
      console.log("test");
      event.preventDefault();
      Swal.fire({
        icon: 'success',
        text: 'Copied to clipboard'
      });
    });
  };

};

export { initSweetalert };
