Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :questions do
        resources :answers do
          resources :votes, only: [:create, :destroy]
        end
      end
      resources :users
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
