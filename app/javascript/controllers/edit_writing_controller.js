import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox", "tagInput", "tagList"];
  checkedBoxes = 0;

  connect() {
    for (const el of this.checkboxTargets) {
      if (el.checked) {
        this.checkedBoxes++;
      }
    }
    if (this.checkedBoxes >= 3) {
      for (const el of this.checkboxTargets) {
        if (!el.checked) {
          el.disabled = true;
        }
      }
    }
  }

  checkLimit(event) {
    if (event.target.checked) {
      this.checkedBoxes++;
    }

    if (this.checkedBoxes >= 3) {
      for (const el of this.checkboxTargets) {
        if (!el.checked) {
          el.disabled = true;
        }
      }
    }

    if (!event.target.checked) {
      if (this.checkedBoxes === 3) {
        for (const el of this.checkboxTargets) {
          if (el.disabled) {
            el.disabled = false;
          }
        }
      }
      this.checkedBoxes--;
    }
  }

  addTag(event) {
    console.log(this.tagInputTarget.value);
  }

  removeTag(event) {}
}
