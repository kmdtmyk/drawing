Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :drawings
  resources :categories, except: [:show]
  resources :customers, except: [:show]
  resources :materials, except: [:show]
  resources :users, except: [:show]

  namespace :statistic do
    resources :drawings, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
