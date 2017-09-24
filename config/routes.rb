Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/dbadmin', as: 'rails_admin'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' # for use with Facebook
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

  root to: 'sessions#new'

  # ** Routes for Errors **
  match "/404", :to => "exception#not_found", :via => :all
  match "/500", :to => "exception#internal_server_error", :via => :all

  # ** Routes for public visitors **

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'about', to: 'pages#about'
  get 'interest', to: 'pages#about'
  get 'contact-us', to: 'pages#contact_us'
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'terms-and-conditions', to: 'pages#terms_and_conditions'

  post 'interest', to: 'contacts#interest'
  post 'enquiry', to: 'contacts#enquiry'

  resources :registrations, only: [:new, :create] do
    get :confirm_email, on: :member
  end

  resources :password_resets, only: [:create, :edit, :update]

  # ** Routes for users with accounts **
  resources :opportunities

  resources :events do
    patch :add_to_profile, on: :member
  end

  resources :artists, only: [:index, :show] do
    resources :series, only: [:show]
    resources :artworks, only: [:show, :index]
    resources :networks, only: [:index]
    resources :organisations, only: [:index]
  end

  resources :professionals, only: [:index, :show] do
    resources :networks, only: [:index]
    resources :organisations, only: [:index]
  end

  resources :companies, only: [:index, :show], path: 'organisations/' do
    patch :join, on: :member
    patch :leave, on: :member
    patch :follow, on: :member
    patch :unfollow, on: :member
  end

  resources :locations, only: [:show]

  namespace :my do
    resource :tags, only: [:create]

    resource :invite, only: [:create]

    resource :feed, only: [:show]

    resource :profile, only: [:edit, :update]

    resource :settings, only: [:show, :update] do
      get :account
      put :deactivate, on: :member
    end

    resource :password, only: [:show, :update]

    resources :connections, only: [:index, :create, :destroy] do
      put :accept, on: :member
      put :reject, on: :member
    end

    resources :companies, only: [:index, :show, :new, :create, :edit, :update], path: 'organisations/' do
      resources :memberships, only: [:create] do
        delete :destroy, on: :collection
        patch :approve, on: :member
        patch :reject, on: :member
      end
    end
  end

  # ** Routes for users with an artist profile **

  namespace :portfolio do
    resources :artwork_collaborators, only: [] do
      patch :accept, on: :member
      patch :reject, on: :member
    end

    resources :series  do
      get :rearrange, on: :member
      patch :set_order, on: :member
      patch :set_cover, on: :member
      patch :publish, on: :member
      patch :unpublish, on: :member

      resources :artworks, only: [:index, :update, :destroy] do
        delete :bulk_destroy, on: :collection
        patch :bulk_update, on: :collection
      end
    end

    resources :artworks, only: [] do
      get :upload, on: :collection
      post :bulk_upload, on: :collection
      post :bulk_group, on: :collection
    end
  end

  # ** Routes for administrators **

  namespace :admin do
    namespace :audits do
      resources :media, :subjects, :specialisations do
        patch :approve, on: :member
        patch :reject, on: :member
      end
    end

    resources :companies, only: [:index, :edit, :update], path: 'organisations/'

    resources :events, only: :index

    resources :users, only: [:index, :show] do
      put :activate, on: :member
      put :deactivate, on: :member
    end

    resources :feeds, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
