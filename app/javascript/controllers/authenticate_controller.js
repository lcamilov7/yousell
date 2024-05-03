import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="authenticate"
export default class extends Controller {
  static targets = ['container']

  signup() {
    this.containerTarget.classList.add('active');
  }

  login() {
    this.containerTarget.classList.remove('active');
  }
}
