Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root to: 'home#top'
  resources :users, except: [:index]
  resources :books
  resources :reviews
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
