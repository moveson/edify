import {Controller} from "@hotwired/stimulus"
import {FetchRequest} from "@rails/request.js";
import Sortable from "sortablejs"

export default class extends Controller {
    static values = { url: String }

    connect() {
        this.sortable = Sortable.create(this.element, {
            onEnd: this.end.bind(this)
        })
    }

    async end(event) {
        const id = event.item.dataset.id
        const patchUrl = this.urlValue.replace(":id", id)
        const request = new FetchRequest(
            "patch", patchUrl,
            {
                query: { "position": event.newIndex + 1 },
                contentType: "application/json",
                responseKind: "json",
            })
        await request.perform()
    }
}
