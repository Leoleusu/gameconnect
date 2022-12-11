Rails.application.routes.draw do

  root to: 'public/homes#top'

  get"search" => "searches#$search"

  namespace :admin do
    resources :posts,only: [:index,:show,:edit,:destroy]
  end

  namespace :public do
    resources :posts do
      resource :favorites,only: [:create,:destroy]
      resources :comments,only: [:show,:edit,:destroy]
    end
    resources :users,only: [:show,:edit,:update] do
      member do
        get :favorites
      end
    end
    get "user/confirm" => 'users#confirm' #退会確認画面
    patch "user/withdrawal" => 'users#withdrawal' #論理削除用のルーティング
    post 'guest_sign_in' => 'sessions#guest_sign_in'
  end

  devise_for :admins

 devise_scope :user do
   post "users/guest_sign_in" => "public/sessions#guest_sign_in"
 end

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


