Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :drawings
  resources :categories, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
