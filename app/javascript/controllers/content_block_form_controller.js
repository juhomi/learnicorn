import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["blockType", "textContent", "imageFileUrl", "imageAltText", "videoFileUrl"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const blockType = this.blockTypeTarget.value
    const allFields = this.element.querySelectorAll('.content-type-fields')
    
    // Hide all fields first and disable their inputs
    allFields.forEach(field => {
      field.style.display = 'none'
      const inputs = field.querySelectorAll('input, textarea')
      inputs.forEach(input => {
        input.disabled = true
      })
    })
    
    // Show the relevant fields and enable their inputs
    const activeFields = this.element.querySelector(`#${blockType}-fields`)
    if (activeFields) {
      activeFields.style.display = 'block'
      
      const inputs = activeFields.querySelectorAll('input, textarea')
      inputs.forEach(input => {
        input.disabled = false
      })
      
      // Focus on the main input field for better UX
      const mainInput = activeFields.querySelector('input[type="text"], input[type="url"], textarea')
      if (mainInput) {
        setTimeout(() => mainInput.focus(), 100)
      }
    }
  }
}