class MarketingController < ApplicationController
  layout 'landing'
  skip_before_action :authenticate_user!
  
  def index
    # Marketing page - no authentication required
  end
end