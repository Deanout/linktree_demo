import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="submit-on-change"
export default class extends Controller {
  connect() {
    this.element.addEventListener("change", this.submitForm.bind(this));
  }

  disconnect() {
    this.element.removeEventListener("change", this.submitForm);
  }

  submitForm(event) {
    event.preventDefault();

    // Use fetch to submit the form via AJAX
    fetch(this.element.action, {
      method: "POST",
      body: new FormData(this.element),
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
      .then((response) => {
        if (response.ok) {
          return response.text();
        } else {
          throw new Error("Network response was not ok");
        }
      })
      .then((data) => {
        // Parse the Turbo-Stream response
        const parser = new DOMParser();
        const doc = parser.parseFromString(data, "text/html");
        const turboStream = doc.querySelector("turbo-stream");

        // Handle the Turbo-Stream action
        if (turboStream) {
          const action = turboStream.getAttribute("action");
          const target = turboStream.getAttribute("target");
          const template = turboStream.querySelector("template");

          switch (action) {
            case "replace":
              document.getElementById(target).replaceWith(template.content);
              break;
            case "update":
              document.getElementById(target).innerHTML = "";
              document.getElementById(target).appendChild(template.content);
              break;
            // Handle other turbo-stream actions as needed
            default:
              console.error("Unknown Turbo-Stream action:", action);
          }
        }
      })
      .catch((error) => {
        console.error(
          "There was a problem with the fetch operation:",
          error.message
        );
      });
  }
}
