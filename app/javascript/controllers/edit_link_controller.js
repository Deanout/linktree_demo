import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="edit-link"
export default class extends Controller {
  static targets = ["content", "form"];
  connect() {
    console.log("Connected the Edit Link Controller");
  }
  showForm(event) {
    this.toggleForm(false);
  }
  hideForm(event) {
    this.toggleForm(true);
  }

  toggleForm(hidden) {
    let content = this.contentTarget;
    let form = this.formTarget;
    const hiddenClass = "d-none";
    if (hidden) {
      content.classList.remove(hiddenClass);
      form.classList.add(hiddenClass);
      return;
    }
    content.classList.add(hiddenClass);
    form.classList.remove(hiddenClass);
  }
}
