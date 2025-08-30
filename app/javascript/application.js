// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Initialize Bootstrap components that don't have Stimulus controllers
document.addEventListener('turbo:load', function() {
  // Initialize alert dismiss buttons (these don't need custom handling)
  if (typeof window.bootstrap !== 'undefined') {
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(alert => {
      const existingInstance = window.bootstrap.Alert.getInstance(alert);
      if (existingInstance) {
        existingInstance.dispose();
      }
      new window.bootstrap.Alert(alert);
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  if (typeof window.bootstrap !== 'undefined') {
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(alert => {
      new window.bootstrap.Alert(alert);
    });
  }
});
