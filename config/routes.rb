Rails.application.routes.draw do
  root 'courses#index'
  get 'about', to: 'pages#about'
  get 'login', to: 'sessions#new'

  resources :courses, except: [:index]
  resources :students
  resources :sessions, only: [:create, :destroy]
end
