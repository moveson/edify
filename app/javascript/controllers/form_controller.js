import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["autofocusInput"]

  clear() {
    this.element.reset()
    this.autofocusInputTarget.focus()
  }
}
