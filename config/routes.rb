Rails.application.routes.draw do

   root to: 'public/homes#top'

  namespace :admin do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/destroy'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/destroy'
    get 'comments/show'
    get 'comments/edit'
    get 'comments/destroy'
    post 'guest_sign_in', to: 'sessions#guest_sign_in'
  end
  devise_for :admins
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


