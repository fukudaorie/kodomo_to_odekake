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

  namespace :admin do
    resources :users, only: [:index] do
      member do
        patch :withdraw
      end
    end
    resources :spots, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    resources :spots do
      resources :posts, only: [:index, :create, :destroy]
      resource :favorites, only: [:create, :destroy, :index]
    end
    get '/map_request', to: 'spots#map', as: 'map_request'
    get 'users/my_page' => 'users#show'
    resources :users, only: [:edit, :update] do
      collection do
        patch :withdraw
      end
      member do
        get :favorites
      end
    end
  end

end
