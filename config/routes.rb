Rails.application.routes.draw do
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
