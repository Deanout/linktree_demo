import { Controller } from "@hotwired/stimulus";
import ahoy from "ahoy.js";

// Connects to data-controller="links"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus! 🎉");
    const link = this.element.dataset.link;
    console.log(link);
  }

  click() {
    console.log("Link was clicked!");
    const link = this.element.dataset.link;
    ahoy.track("Clicked Link", { link: link });
  }
}
