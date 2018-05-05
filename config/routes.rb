Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :user, only: [:edit, :update] do
    resource :password, only: [:update], module: :user
  end

  resources :drawings do
    resource :thumbnail, only: [:edit, :update], module: :drawings
  end
  resources :categories, except: [:show]
  resources :customers, except: [:show]
  resources :materials, except: [:show]
  resources :processing_types, except: [:show]
  resources :notices, except: [:show]

  namespace :admin do
    resources :users, except: [:show]
  end

  namespace :statistic do
    resources :drawings, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
