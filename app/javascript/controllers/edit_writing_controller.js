import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox", "tagInput", "tagList", "submit", "cancel"];

  static values = {
    initialTitle: String,
    initialDescription: String,
    initialCreator: String,
    initialWritingType: String,
    initialGenres: Array,
    initialTags: Array,
    currentTags: Array,
    checkedBoxes: Number,
  };

  initialize() {}

  connect() {
    this.checkboxTargets.forEach((el) => {
      if (el.checked) {
        this.checkedBoxesValue++;
        this.initialGenres = [...this.initialGenres, el.value];
      }
    });

    if (this.checkedBoxesValue >= 3) {
      this.checkboxTargets.forEach((el) => {
        if (!el.checked) {
          el.disabled = true;
        }
      });
    }
  }

  registerChange() {
    // console.log(this.submitTarget);
    this.submitTarget.disabled = false;
    this.cancelTarget.disabled = false;
  }

  cancelUpdate() {
    console.log(this.cancelTarget);
  }

  checkLimit(event) {
    this.registerChange();
    if (event.target.checked) {
      this.checkedBoxesValue++;
    }

    if (this.checkedBoxesValue >= 3) {
      for (const el of this.checkboxTargets) {
        if (!el.checked) {
          el.disabled = true;
        }
      }
    }

    if (!event.target.checked) {
      if (this.checkedBoxesValue === 3) {
        for (const el of this.checkboxTargets) {
          if (el.disabled) {
            el.disabled = false;
          }
        }
      }
      this.checkedBoxesValue--;
    }
  }

  addTag(event) {
    event.preventDefault();
    this.registerChange();

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
    this.registerChange();
    const span = event.target.closest(".tagSpan");
    span.remove();
  }
}
