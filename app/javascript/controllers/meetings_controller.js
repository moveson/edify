import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "todayIndicator",
  ]

  connect() {
    if (this.hasTodayIndicatorTarget) {
      this.todayIndicatorTarget.scrollIntoView({ behavior: "smooth", block: "end" })
    }
  }
}
