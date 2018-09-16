Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:index, :create, :show, :update, :destroy] do
        resources :answers, only: [:index, :create, :show, :update, :destroy] do
          resources :votes, only: [:create, :destroy]
        end
      end
      resources :users, only: [:index, :create, :show, :update, :destroy]
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
