import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["submitButton"]

    connect() {
        const controller = this
        const form = this.element
        this.submitButtonTarget.classList.add("disabled")

        Array.from(form).forEach(function (el) {
            if(el.type !== "hidden") {
                el.dataset.origValue = el.value
                el.addEventListener("input", function () {
                    controller.enableSubmitIfChanged()
                })
            }
        })
    }

    enableSubmitIfChanged() {
        if(this.formHasChanges()) {
            this.submitButtonTarget.classList.remove("disabled")
        } else {
            this.submitButtonTarget.classList.add("disabled")
        }
    }

    formHasChanges() {
        const form = this.element
        return Array.from(form).some(el => 'origValue' in el.dataset && el.dataset.origValue !== el.value)
    }
}
