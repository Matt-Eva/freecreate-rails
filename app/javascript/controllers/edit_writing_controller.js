import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "title",
    "creator",
    "writingType",
    "genreCheckbox",
    "tagInput",
    "tagList",
    "description",
    "submit",
    "cancel",
  ];

  static values = {
    initialTitle: String,
    initialCreator: String,
    initialWritingType: String,
    initialGenres: Array,
    initialTags: Array,
    initialDescription: String,
    currentTags: Array,
    checkedBoxes: Number,
  };

  initialize() {}

  connect() {
    this.#populateInitialValues();
  }

  #populateInitialValues() {
    this.initialTitleValue = this.titleTarget.value;
    this.initialCreatorValue = this.creatorTarget.value;
    this.initialWritingTypeValue = this.writingTypeTarget.value;
    this.#populateInitialGenres();
    this.#populateInitialTags();
    this.initialDescriptionValue = this.descriptionTarget.value;
    console.log(this.initialTitleValue);
    console.log(this.initialCreatorValue);
    console.log(this.initialWritingTypeValue);
    console.log(this.initialGenresValue);
    console.log(this.initialTagsValue);
    console.log("initialDescriptionvalue", this.initialDescriptionValue);
  }

  #populateInitialGenres() {
    this.genreCheckboxTargets.forEach((el) => {
      if (el.checked) {
        this.checkedBoxesValue++;
        this.initialGenresValue = [...this.initialGenresValue, el.value];
      }
    });

    if (this.checkedBoxesValue >= 3) {
      this.genreCheckboxTargets.forEach((el) => {
        if (!el.checked) {
          el.disabled = true;
        }
      });
    }
  }

  #populateInitialTags() {
    const tagSpanTexts = document.getElementsByClassName(".tagSpanText");
    for (const span of tagSpanTexts) {
      this.InitialTagsValue = [...this.InitialTagsValue, span.textContent];
    }
  }

  registerChange() {
    this.submitTarget.disabled = false;
    this.cancelTarget.disabled = false;
  }

  cancelUpdate() {
    this.submitTarget.disabled = true;
    this.cancelTarget.disabled = true;
    this.titleTarget.value = this.initialTitleValue;
  }
  #restoreInitialGenres() {}
  #restoreInitialTags() {}

  checkLimit(event) {
    this.registerChange();
    if (event.target.checked) {
      this.checkedBoxesValue++;
    }

    if (this.checkedBoxesValue >= 3) {
      for (const el of this.genreCheckboxTargets) {
        if (!el.checked) {
          el.disabled = true;
        }
      }
    }

    if (!event.target.checked) {
      if (this.checkedBoxesValue === 3) {
        for (const el of this.genreCheckboxTargets) {
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
    const lowercaseTagInputText = tagInputText.toLowerCase();
    const splitInput = lowercaseTagInputText.split(" ");
    const filteredInput = splitInput.filter((str) => str !== "");
    const rejoinedInput = filteredInput.join("-");

    const exists = this.currentTagsValue.find((val) => val === rejoinedInput);
    if (exists) {
      this.tagInputTarget.value = "";
      return;
    }

    this.currentTagsValue = [...this.currentTagsValue, rejoinedInput];

    const span = document.createElement("span");
    span.className = "tagSpan";
    span.setAttribute("data-action", "click->edit-writing#removeTag");

    const tagText = document.createElement("span");
    tagText.className = "tagSpanText";
    tagText.textContent = rejoinedInput;

    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "writing[tags][]";
    hiddenInput.value = rejoinedInput;

    span.append(tagText, hiddenInput);

    this.tagListTarget.append(span);
    this.tagInputTarget.value = "";
    this.tagInputTarget.focus();
  }

  removeTag(event) {
    this.registerChange();
    const tagText = event.target.textContent;
    this.currentTagsValue = this.currentTagsValue.filter(
      (tag) => tag !== tagText,
    );
    const span = event.target.closest(".tagSpan");
    span.remove();
  }
}
