Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#new_guest'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    root to: 'homes#top'
    resources :spots do
      resources :posts, only: [:index, :create]
    end
    get 'users/my_page' => 'users#show'
    resources :users, only: [:edit, :update] do
      collection do
        patch :withdraw
      end
    end

  end
end
