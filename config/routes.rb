Rails.application.routes.draw do
  get '/generations/:id/question_cards', to: 'generations#question_cards'
  get '/generations/:id/answers', to: 'generations#answers'
  resources :generations

  resources :question_cards

  match 'tasks_groups/:id/add_task', to: 'tasks_groups#add_task', via: [:put]
  match 'tasks_groups/:id/remove_task', to: 'tasks_groups#remove_task', via: [:delete]
  resources :tasks_groups

  get 'tasks/my_tasks'
  resources :tasks

  devise_for :users

  root 'main_page#index'

  get 'main_page/index'
  get 'main_page/welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
