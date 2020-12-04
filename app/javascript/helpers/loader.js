
const loader = () => {

  const button1 = document.getElementsByClassName("submit-button")[0];
  const button2 = document.getElementsByClassName("submit-button")[1];
  if (button1 ) {
    button1.addEventListener("click", () => {
      document.getElementsByClassName("overlay")[0].style.display = "block";
    });
  }
    if (button2) {
    button2.addEventListener("click", () => {
      document.getElementsByClassName("overlay")[0].style.display = "block";
    });
  }
}

export {loader};
