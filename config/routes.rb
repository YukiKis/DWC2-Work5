Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
    get :followings, :followers
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
end