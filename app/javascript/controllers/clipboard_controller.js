import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["button", "source"]

    copy() {
        navigator.clipboard.writeText(this.sourceTarget.innerText)
        this.flashButton()
    }

    flashButton() {
        const button = this.buttonTarget;
        const icon = button.querySelector("i")

        button.classList.add("btn-primary")
        button.classList.remove("btn-outline-primary")
        icon.classList.add("fa-clipboard-check")
        icon.classList.remove("fa-clipboard")

        setTimeout(() => {
            button.classList.remove("btn-primary")
            button.classList.add("btn-outline-primary")
            icon.classList.remove("fa-clipboard-check")
            icon.classList.add("fa-clipboard")
        }, 600)
    }
}
