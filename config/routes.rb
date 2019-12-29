Rails.application.routes.draw do
  root 'courses#index'
  get 'about', to: 'pages#about'

  resources :courses, except: [:index]
end
