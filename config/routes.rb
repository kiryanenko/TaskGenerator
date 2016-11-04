Rails.application.routes.draw do
  get '/generations/:id/question_cards', to: 'generations#question_cards'
  get '/generations/:id/answers', to: 'generations#answers'
  resources :generations
  resources :question_cards
  resources :tasks_groups
  get 'tasks/my_tasks'
  resources :tasks

  devise_for :users
  root 'main_page#index'

  get 'main_page/index'

  get 'main_page/welcome'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
