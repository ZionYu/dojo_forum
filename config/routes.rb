Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  resources :posts do
    resources :replies, only: [:create, :edit, :update, :destroy]
  end
  resources :categories, only: [:show]
  resources :users, only: [:show, :edit, :update] do
    member do
      get :post
      get :reply
      get :draft
      get :collect
      get :friend
    end
  end

  namespace :admin do
    root "categories#index"
    resources :users, only:[:index, :update]
    resources :categories
  end
end
