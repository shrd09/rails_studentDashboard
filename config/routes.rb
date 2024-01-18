Rails.application.routes.draw do


  resources :users, only: [:create, :delete_user, :index]
  resources :sessions, only: [:create, :destroy]
  post '/users/sign_in', to: 'sessions#create'
  delete '/users/:email', to: 'users#delete_user'

  get '/users/all', to: 'users#index'

  delete '/sessions', to: 'sessions#destroy'

  get '/users/:id/enrolled_courses', to: 'enrollments#show'

  
  post '/users', to: 'users#create'

  resources :students, only: [:index,:create, :destroy, :show]
 
  post '/student-details', to: 'students#create'
  get '/students/:id', to: 'students#show'

  # RESTful routes for managing teachers
  resources :teachers, only: [:index, :create, :destroy, :show]
  post '/teacher-details', to: 'teachers#create'
  resources :courses, only: [:show, :index,:index_by_courses]
  get '/teachers/:id/courses', to: 'courses#show'
  get '/teachers/:id', to: 'teachers#show'
  get '/courses', to: 'courses#index'
  post '/courses-add', to: 'courses#create'

  resources :enrollments, only: [:create, :update_marks, :show, :index]
  post '/enrollments', to: 'enrollments#create'
  get 'teachers/:id/enrollments', to: 'enrollments#index'
  get '/users/:id/enrolled_courses', to: 'enrollments#show'

  get 'courses/:courseId/marks', to: 'courses#show_marks'

  get 'users/:id/enrollments', to: 'enrollments#show'
  get '/courses/:course_ids/enrollments', to: 'enrollments#index_by_courses'

  put 'enrollments/:id', to: 'enrollments#update_marks'

  # Add a new route to retrieve the CSRF token
  get '/get_csrf_token', to: 'application#get_csrf_token'

  post '/refresh-token', to: 'tokens#refresh_token'

  get '/user', to: 'users#show', as:'user'

  get 'courses/:course_id/students', to: 'students#students_by_course', as: 'students_by_course'

  get '/teachers', to: 'teachers#index'

  put '/users/:email', to: 'users#update'
  root 'homepage#index'
end
