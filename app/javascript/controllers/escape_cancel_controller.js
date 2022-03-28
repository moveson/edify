import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["link"]

    connect() {
        this.element.addEventListener("keydown", event => {
            if(event.key === "Escape") {
                this.linkTarget.click()
            }
        })
    }
}
