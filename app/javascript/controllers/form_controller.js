import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["clear"]

  clear() {
    this.element.reset()
    this.clearTargets.forEach((element) => {
      element.innerHTML = null
    })
    const autofocusElement = this.element.querySelector("[autofocus=autofocus]")

    if (autofocusElement !== null) {
      autofocusElement.focus()
    }
  }
}
