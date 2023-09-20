import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.copyToast = document.getElementById("copy-toast");

    // Initialize Bootstrap 5 toast
    this.bsToast = new bootstrap.Toast(this.copyToast);
  }

  // Copy to clipboard action
  copy(e) {
    e.preventDefault();
    const url = this.urlValue;
    navigator.clipboard.writeText(url).then(() => {
      this.bsToast.show();
      setTimeout(() => {
        this.bsToast.hide();
      }, 5000);
    });
  }
}
