
const loader = () => {
  console.log("loader running");

  const button = document.getElementsByClassName("submit-button")[0];
  console.log(button);
  button.addEventListener("click", () => {
    console.log("click running");
    document.getElementsByClassName("overlay")[0].style.display = "block";

  });

}

export {loader};


