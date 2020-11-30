const menuToggle = () => {
  const menuBody = document.getElementById('menuBody');
  const openMenu = document.getElementById('menuControlOpen'); // or whatever triggers the toggle
  const closeMenu = document.getElementById('menuControlClose'); // or whatever triggers the toggle
  console.log(menuBody);
  console.log(openMenu);
  console.log(closeMenu);

  openMenu.addEventListener('click', (e) => {
    menuBody.classList.toggle('menu--active'); // or whatever your active class is
  });

  closeMenu.addEventListener('click', (e) => {
    menuBody.classList.toggle('menu--active'); // or whatever your active class is
  });
}

export { menuToggle };
