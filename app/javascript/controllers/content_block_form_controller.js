import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["blockType"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const blockType = this.blockTypeTarget.value
    const allFields = this.element.querySelectorAll('.content-type-fields')
    
    // Hide all fields first
    allFields.forEach(field => {
      field.style.display = 'none'
    })
    
    // Show the relevant fields
    const activeFields = this.element.querySelector(`#${blockType}-fields`)
    if (activeFields) {
      activeFields.style.display = 'block'
    }
  }
}