import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    clear() {
        this.element.reset()
        const autofocusElement = this.element.querySelector("[autofocus=autofocus]")

        if (autofocusElement !== null) {
            autofocusElement.focus()
        }
    }
}
