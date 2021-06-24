Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'

  devise_for :users

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :events, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :notifications, only: [:index]
    delete 'destroy_all' => 'notifications#destroy_all'
  end

  get "search" => "searches#search"

  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  get 'thanks', to: 'contacts#thanks', as: 'thanks'
end
