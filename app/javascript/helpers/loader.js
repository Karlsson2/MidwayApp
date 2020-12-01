
const loader = () => {
  const button = document.getElementsByClassName("submit-button")[0];
  if (button) {
    button.addEventListener("click", () => {
      document.getElementsByClassName("overlay")[0].style.display = "block";
    });
  }
}

export {loader};
