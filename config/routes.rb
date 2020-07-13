Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root to: 'home#top'
  resources :users, except: [:index]
  resources :books
  resources :reviews
  get "/auth/:provider/callback", to: "users#create", as: :auth_callback
  get "/auth/failure", to: "users#auth_failure", as: :auth_failure
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

