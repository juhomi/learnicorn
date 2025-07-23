Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  # Root path - show marketing landing page for non-authenticated users
  root 'home#index'
  
  # Marketing page
  get '/marketing', to: 'marketing#index'
  
  # Dashboard route for authenticated users
  get '/dashboard', to: 'dashboard#index'
  
  # Public course browsing
  resources :courses, only: [:index, :show] do
    member do
      post :enroll
    end
    resources :lessons, only: [:show] do
      member do
        post :complete
      end
    end
  end
  
  # Admin namespace
  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :users
    resources :courses
    resources :lessons
    resources :enrollments, only: [:index, :show, :destroy]
  end
  
  # Instructor namespace
  namespace :instructor do
    get '/', to: 'dashboard#index'
    resources :courses do
      resources :lessons
    end
    resources :enrollments, only: [:index, :show]
  end
  
  # Student namespace
  namespace :student do
    get '/', to: 'dashboard#index'
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show]
    end
    resources :enrollments, only: [:index, :show]
  end
end
