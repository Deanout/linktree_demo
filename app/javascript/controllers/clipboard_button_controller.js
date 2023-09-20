import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard-button"
export default class extends Controller {
  static values = { url: String };
  connect() {
    console.log("URL:", this.urlValue);
  }

  // Copy to clipboard action
  copy(e) {
    e.preventDefault();
    const url = this.urlValue;
    navigator.clipboard.writeText(url).then(() => {
      this.element.classList.add("copied");
      setTimeout(() => {
        this.element.classList.remove("copied");
      }, 1000);
    });
  }
}
