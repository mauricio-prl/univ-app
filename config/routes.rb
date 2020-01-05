Rails.application.routes.draw do
  root 'courses#index'
  get 'about', to: 'pages#about'
  get 'login', to: 'sessions#new'
  post 'course_enroll', to: 'student_courses#create'
  delete 'course_enroll', to: 'student_courses#destroy'

  resources :courses, except: [:index]
  resources :students
  resources :sessions, only: [:create, :destroy]
end
