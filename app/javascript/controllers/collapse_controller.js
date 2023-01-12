import { Controller } from "@hotwired/stimulus"
import "bootstrap"

export default class extends Controller {
    connect() {
        var collapseElementList = [].slice.call(document.querySelectorAll('.collapse'))
        var collapseList = collapseElementList.map(function (collapseEl) {
            return new bootstrap.Collapse(collapseEl)
        })
    }
}
