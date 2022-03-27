import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["speakerNameInput"]

  clear() {
    this.element.reset()
    this.speakerNameInputTarget.focus()
  }
}
