import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    reorderUrl: String 
  }
  
  static targets = ["container"]

  connect() {
    this.setupSortable()
  }

  setupSortable() {
    // Add drag and drop functionality
    this.element.addEventListener('dragstart', this.handleDragStart.bind(this))
    this.element.addEventListener('dragover', this.handleDragOver.bind(this))
    this.element.addEventListener('drop', this.handleDrop.bind(this))
    this.element.addEventListener('dragend', this.handleDragEnd.bind(this))

    // Make content blocks draggable
    this.contentBlocks.forEach(block => {
      block.setAttribute('draggable', true)
      block.classList.add('draggable-content-block')
    })
  }

  get contentBlocks() {
    return this.element.querySelectorAll('.content-block-item')
  }

  handleDragStart(event) {
    if (!event.target.closest('.content-block-item')) return
    
    const contentBlock = event.target.closest('.content-block-item')
    event.dataTransfer.setData('text/plain', contentBlock.dataset.contentBlockId)
    event.dataTransfer.effectAllowed = 'move'
    
    contentBlock.classList.add('dragging')
    this.draggedElement = contentBlock
  }

  handleDragOver(event) {
    event.preventDefault()
    event.dataTransfer.dropEffect = 'move'

    const afterElement = this.getDragAfterElement(event.clientY)
    const draggingElement = this.draggedElement

    if (afterElement == null) {
      this.element.appendChild(draggingElement)
    } else {
      this.element.insertBefore(draggingElement, afterElement)
    }
  }

  handleDrop(event) {
    event.preventDefault()
    this.updatePositions()
  }

  handleDragEnd(event) {
    if (this.draggedElement) {
      this.draggedElement.classList.remove('dragging')
      this.draggedElement = null
    }
  }

  getDragAfterElement(y) {
    const draggableElements = [...this.contentBlocks].filter(child => 
      !child.classList.contains('dragging')
    )

    return draggableElements.reduce((closest, child) => {
      const box = child.getBoundingClientRect()
      const offset = y - box.top - box.height / 2

      if (offset < 0 && offset > closest.offset) {
        return { offset: offset, element: child }
      } else {
        return closest
      }
    }, { offset: Number.NEGATIVE_INFINITY }).element
  }

  updatePositions() {
    const contentBlockIds = [...this.contentBlocks].map(block => 
      block.dataset.contentBlockId
    )

    fetch(this.reorderUrlValue, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({
        content_block_ids: contentBlockIds
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === 'success') {
        this.updatePositionLabels()
        this.showSuccessMessage()
      }
    })
    .catch(error => {
      console.error('Error updating positions:', error)
      this.showErrorMessage()
    })
  }

  updatePositionLabels() {
    this.contentBlocks.forEach((block, index) => {
      const positionLabel = block.querySelector('.position-indicator')
      if (positionLabel) {
        positionLabel.textContent = `#${index + 1}`
      }
      block.dataset.position = index + 1
    })
  }

  showSuccessMessage() {
    const alert = document.createElement('div')
    alert.className = 'alert alert-success alert-dismissible fade show'
    alert.innerHTML = `
      Content blocks reordered successfully!
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `
    this.element.insertBefore(alert, this.element.firstChild)
    
    setTimeout(() => {
      if (alert.parentNode) {
        alert.remove()
      }
    }, 3000)
  }

  showErrorMessage() {
    const alert = document.createElement('div')
    alert.className = 'alert alert-danger alert-dismissible fade show'
    alert.innerHTML = `
      Error reordering content blocks. Please try again.
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `
    this.element.insertBefore(alert, this.element.firstChild)
  }
}