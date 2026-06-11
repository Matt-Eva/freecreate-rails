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
    this.submitTarget.disabled = true;
    this.cancelTarget.disabled = true;
  }

  #populateInitialValues() {
    this.initialTitleValue = this.titleTarget.value;
    this.initialCreatorValue = this.creatorTarget.value;
    this.initialWritingTypeValue = this.writingTypeTarget.value;
    this.#populateInitialGenres();
    this.#populateInitialTags();
    this.initialDescriptionValue = this.descriptionTarget.value;
    console.log(this.initialGenresValue);
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
    const tagSpanTexts = document.getElementsByClassName("tagSpanText");
    for (const span of tagSpanTexts) {
      this.initialTagsValue = [...this.initialTagsValue, span.textContent];
      this.currentTagsValue = this.InitialTagsValue;
    }
  }

  cancelUpdate() {
    this.submitTarget.disabled = true;
    this.cancelTarget.disabled = true;
    this.titleTarget.value = this.initialTitleValue;
    this.creatorTarget.value = this.initialCreatorValue;
    this.writingTypeTarget.value = this.initialWritingTypeValue;
    this.descriptionTarget.value = this.initialDescriptionValue;
    this.#restoreInitialTags();
    this.#restoreInitialGenres();
  }

  #restoreInitialGenres() {
    this.checkedBoxesValue = 0;
    this.genreCheckboxTargets.forEach((target) => {
      const selected = this.initialGenresValue.find(
        (genre) => genre === target.value,
      );
      if (selected) {
        target.checked = true;
        this.checkedBoxesValue++;
      } else {
        target.checked = false;
      }
      target.disabled = false;
    });

    if (this.checkedBoxesValue >= 3) {
      this.genreCheckboxTargets.forEach((target) => {
        if (!target.checked) {
          target.disabled = true;
        }
      });
    }
  }

  #restoreInitialTags() {
    this.tagListTarget.innerHTML = "";
    this.currentTagsValue = [];
    this.initialTagsValue.forEach((tag) => {
      this.addTag(tag);
    });
  }

  registerChange() {
    this.submitTarget.disabled = false;
    this.cancelTarget.disabled = false;
  }

  checkLimit(event) {
    this.registerChange();
    console.log(event.target);
    const noGenreCheckbox = this.genreCheckboxTargets.find(
      (el) => el.value === "No Topic",
    );

    if (event.target.value === "No Topic") {
      console.log("no topic");
      this.checkedBoxesValue = 0;

      for (const el of this.genreCheckboxTargets) {
        el.checked = false;
        el.disabled = false;
      }

      event.target.checked = true;
      event.target.disabled = true;
      return;
    } else if (event.target.checked) {
      this.checkedBoxesValue++;

      noGenreCheckbox.checked = false;
      noGenreCheckbox.disabled = false;
    }

    if (this.checkedBoxesValue >= 3) {
      for (const el of this.genreCheckboxTargets) {
        if (el.value === "No Topic") {
          continue;
        }
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
      if (this.checkedBoxesValue === 0) {
        noGenreCheckbox.checked = true;
        // noGenreCheckbox.disabled = true;
      }
    }
  }

  handleAddTag(event) {
    this.registerChange();
    event.preventDefault();
    if (this.currentTagsValue.length >= 20) {
      return;
    }

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
    this.addTag(rejoinedInput);
  }

  addTag(tag) {
    this.currentTagsValue = [...this.currentTagsValue, tag];

    const span = document.createElement("span");
    span.className = "tagSpan";
    span.setAttribute("data-action", "click->edit-writing#removeTag");

    const tagText = document.createElement("span");
    tagText.className = "tagSpanText";
    tagText.textContent = tag;

    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "writing[tags][]";
    hiddenInput.value = tag;

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
