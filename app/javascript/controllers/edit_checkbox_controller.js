import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox"];
  connect() {
    console.log("hello stimulus", this.element);
  }
  checkLimit(event) {
    console.log(event.target);
  }
}
