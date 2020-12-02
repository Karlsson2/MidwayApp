// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import 'bootstrap';
import { initMapbox } from '../plugins/init_mapbox';
import { loader } from 'helpers/loader.js';
import { menuToggle } from '../components/navbar';
import { initSweetalert } from '../plugins/init_sweetalert';
import {typewrite} from '../components/typewriter';
import flatpickr from "flatpickr";
// import { showTab, nextPrev, validateForm, fixStepIndicator } from "../components/form";

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  menuToggle();
  initSweetalert();
  typewrite();

  const date = new Date().toLocaleTimeString('en-GB', { hour: "numeric", minute: "numeric"});
  flatpickr(".datepicker", { minDate: "today", defaultDate: "today", dateFormat: "d m Y" });
  flatpickr(".timepicker", { enableTime: true, defaultDate: date, noCalendar: true, dateFormat: "H:i", time_24hr: true});

  loader();
  // showTab();
  // nextPrev();
  // validateForm();
  // fixStepIndicator();

});


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
