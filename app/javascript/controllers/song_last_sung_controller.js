import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";

export default class extends Controller {

  static values = {
    date: String,
    unitId: String,
  }

  update() {
    const url = "/units/" + this.unitIdValue + "/song_last_sung"

    get(url, {
      query: {
        date: this.dateValue,
        title: this.element.value,
      },
      responseKind: "turbo-stream"
    })
  }
}
