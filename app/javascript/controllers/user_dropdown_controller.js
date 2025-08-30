import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-dropdown"
export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    console.log("User dropdown controller connected")
    // Close dropdown when clicking outside
    this.boundCloseOnOutsideClick = this.closeOnOutsideClick.bind(this)
  }

  disconnect() {
    document.removeEventListener('click', this.boundCloseOnOutsideClick)
  }

  toggle(event) {
    event.preventDefault()
    console.log("Toggling dropdown")
    
    if (this.hasMenuTarget) {
      const isOpen = this.menuTarget.classList.contains('show')
      
      if (isOpen) {
        this.close()
      } else {
        this.open()
      }
    }
  }

  open() {
    console.log("Opening dropdown")
    if (this.hasMenuTarget) {
      this.menuTarget.classList.add('show')
      // Add click listener to close when clicking outside
      setTimeout(() => {
        document.addEventListener('click', this.boundCloseOnOutsideClick)
      }, 10)
    }
  }

  close() {
    console.log("Closing dropdown")
    if (this.hasMenuTarget) {
      this.menuTarget.classList.remove('show')
      document.removeEventListener('click', this.boundCloseOnOutsideClick)
    }
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}