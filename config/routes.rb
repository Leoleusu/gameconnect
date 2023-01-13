Rails.application.routes.draw do

  root to: 'public/homes#top'

  get"search" => "searches#$search"

  namespace :admin do
    resources :posts,only: [:index,:show,:edit,:destroy]
    resources :users,only: [:index,:show,:edit,:update]
    resources :comments,only: [:index,:show,:edit,:destroy]
  end

  devise_for :admin,controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    resources :posts do
      resource :favorites,only: [:create,:destroy]
      resources :comments,only: [:create,:edit,:destroy]
    end
    resources :users,only: [:show,:edit,:update] do
      resource :relationships, only: [:create,:destroy]
      get'followings' => 'relationships#followings', as: 'followings'
      get'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
    end
    resources :notifications, only: :index
    get "user/confirm" => 'users#confirm' #退会確認画面
    patch "user/withdrawal" => 'users#withdrawal' #論理削除用のルーティング
    post 'guest_sign_in' => 'sessions#guest_sign_in' #ゲストログイン用のルーティング
  end

 devise_scope :user do
   post "users/guest_sign_in" => "public/sessions#guest_sign_in"
 end

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


