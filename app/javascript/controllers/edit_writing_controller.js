import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox", "tagInput", "tagList"];

  initialize() {
    this.checkedBoxes = 0;
    this.existingTags = new Set();
  }

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
    event.preventDefault();

    const tagInputText = this.tagInputTarget.value.trim();

    const span = document.createElement("span");
    span.className = "tagSpan";
    span.setAttribute("data-action", "click->edit-writing#removeTag");

    const tagText = document.createElement("span");
    tagText.className = "tagSpanText";
    tagText.textContent = tagInputText;

    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "writing[tags][]";
    hiddenInput.value = tagInputText;

    span.append(tagText, hiddenInput);

    this.tagListTarget.append(span);
    this.tagInputTarget.value = "";
    this.tagInputTarget.focus();
  }

  removeTag(event) {
    console.log("running");
    console.log(event.target);
  }
}
