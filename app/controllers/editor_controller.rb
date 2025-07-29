class EditorController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    # For now, just render the editor view
    # In the future, we can add authentication checks or load specific files
  end
end