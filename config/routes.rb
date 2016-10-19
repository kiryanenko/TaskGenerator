Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  resources :question_cards
  resources :tasks_groups
  resources :tasks
  devise_for :users
  root 'main_page#index'

  get 'main_page/index'

  get 'main_page/welcome'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
