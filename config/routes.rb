Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  resources :posts
  resources :categories, only: [:show]

  namespace :admin do
    root "categories#index"
    resources :users, only:[:index, :update]
    resources :categories
  end
end
