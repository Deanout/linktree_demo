import { Controller } from "@hotwired/stimulus";
import ahoy from "ahoy.js";

// Connects to data-controller="links"
export default class extends Controller {
  click() {
    const link = this.element.dataset.link;
    ahoy.track("Clicked Link", { link: link });
  }
}
