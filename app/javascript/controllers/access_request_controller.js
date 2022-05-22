import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    static targets = ["approveButton", "roleDescription", "roleSelector"]

    connect() {
        this.disableOrEnableApproveButton()
        this.hideOrShowRoleDescriptions()
    }

    disableOrEnableApproveButton() {
        if (this.roleSelectorTarget.value.length === 0) {
            this.approveButtonTarget.classList.add("disabled")
        } else {
            this.approveButtonTarget.classList.remove("disabled")
        }

    }

    hideOrShowRoleDescriptions() {
        const role = this.roleSelectorTarget.value

        this.roleDescriptionTargets.forEach((element) => {
            if (element.id === role) {
                element.classList.remove("d-none");
            } else {
                element.classList.add("d-none");
            }
        })
    }
}
