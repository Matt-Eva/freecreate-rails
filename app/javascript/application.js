// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "trix";
import "@rails/actiontext";
document.addEventListener("trix-file-accept", (event) => {
  event.preventDefault();
  // Alert the user so they know WHY it didn't work
  alert(
    "Sorry, this editor only supports text for now! Images and files cannot be uploaded.",
  );
});
