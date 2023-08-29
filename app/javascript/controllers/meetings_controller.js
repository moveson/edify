import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "todayIndicator",
  ]

  connect() {
    if (this.hasTodayIndicatorTarget) {
      this.todayIndicatorTarget.scrollIntoView({ behavior: "smooth", block: "end" })

      // Wait for scroll to finish, then scroll up a bit
      setTimeout(() => {
        window.scrollBy(0, 100)
      }, 200)
    }
  }
}
