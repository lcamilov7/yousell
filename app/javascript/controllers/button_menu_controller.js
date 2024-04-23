import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button-menu"
export default class extends Controller {
  static targets = ['menu']

  toggle() {
    this.menuTarget.classList.toggle('translate-x-full');
  }
}
