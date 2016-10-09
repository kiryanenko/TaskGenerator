Rails.application.routes.draw do
  devise_for :users
  root 'main_page#index'

  get 'main_page/index'

  get 'main_page/welcome'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
