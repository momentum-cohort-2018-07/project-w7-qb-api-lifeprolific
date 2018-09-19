Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:index, :create, :show, :update, :destroy] do
        resources :answers, only: [:create, :update, :destroy] do
          resources :votes, only: [:create]
        end
      end
      resources :users, only: [:create, :show, :update, :destroy]
      get '/request_token', to: 'users#request_token'
    end
  end

  resources :questions do
    resources :answers do
      resources :votes, only: [:create, :destroy]
    end
  end
  resources :users
  resource :session, only: [:new, :create, :destroy]
  root 'questions#index'
  
  get '/multisearch', to: 'multisearch#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
