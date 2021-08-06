Rails.application.routes.draw do

  root 'root#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :user, only: [:edit, :update] do
    resource :password, only: [:edit, :update], module: :user
  end

  resources :drawings do
    resource :thumbnail, only: [:edit, :update], module: :drawings
  end
  delete :drawings, to: 'drawings#destroy'

  resources :categories, except: [:show]
  resources :customers, except: [:show]
  resources :materials, except: [:show]
  resources :processing_types, except: [:show]
  resources :notices, except: [:show]

  get '/backup', to: 'backup#index'
  get '/backup/:filename', to: 'backup#download'

  namespace :admin do
    resources :users, except: [:show]
  end

  namespace :statistic do
    resources :drawings, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
