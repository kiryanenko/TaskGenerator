Rails.application.routes.draw do
  get '/generations/:id/question_cards', to: 'generations#question_cards'
  get '/generations/:id/answers', to: 'generations#answers'
  get 'generations/my', to: 'generations#my_generations'
  resources :generations

  get 'question_cards/my', to: 'question_cards#my_cards'
  get 'question_cards/:id/add_to_me', to: 'question_cards#add_to_me'
  resources :question_cards

  match 'tasks_groups/:id/add_task', to: 'tasks_groups#add_task', via: [:put]
  match 'tasks_groups/:id/remove_task', to: 'tasks_groups#remove_task', via: [:delete]
  get 'tasks_groups/my_groups'
  get 'tasks_groups/my', to: 'tasks_groups#my_groups'
  get 'tasks_groups/:id/add_to_me', to: 'tasks_groups#add_to_me'
  resources :tasks_groups

  get 'tasks/my_tasks'
  get 'tasks/my', to: 'tasks#my_tasks'
  get 'tasks/:id/add_to_me', to: 'tasks#add_to_me'
  resources :tasks

  devise_for :users

  root 'main_page#index'

  get 'main_page/index'
  get 'main_page/welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
