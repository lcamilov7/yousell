import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button-menu"
export default class extends Controller {
  static targets = ['button', 'menu']
  connect() {
    console.log(this.buttonTarget);
    console.log(this.menuTarget);
  }

  fire() {
    this.menuTarget.classList.toggle('translate-x-full');
  }
}
