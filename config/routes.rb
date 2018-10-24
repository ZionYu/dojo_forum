Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  resources :posts do
    resources :replies, only: [:create, :edit, :update, :destroy]
    collection do
      get :feeds
    end
    member do
      post :collect
      post :uncollect
    end
  end

  resources :categories, only: [:show]
  resources :users, only: [:show, :edit, :update] do
    member do
      get :post
      get :reply
      get :draft
      get :collect
      get :friend
      post :friend_request
      post :friend_accept
      post :friend_ignore   
    end
  end

  namespace :admin do
    root "categories#index"
    resources :users, only:[:index, :update]
    resources :categories
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create, :update, :destroy]
    end
  end
  
end
