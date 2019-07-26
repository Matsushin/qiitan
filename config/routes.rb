Rails.application.routes.draw do
  mount_roboto
  root to: 'home#index'

  resources :articles, only: %i[show new create edit update destroy] do
    collection do
      post :preview
    end
    resources :stocks, only: %i[create destroy], format: :js
    resources :likes, only: %i[create destroy], format: :js
    resources :comments, only: %i[create update destroy]
  end

  devise_for :users

  devise_scope :user do
    post 'users/edit/confirm_destroy' => 'users/registrations#confirm_destroy'
    delete 'users/edit/complete_destroy' => 'users/registrations#complete_destroy'
  end

  resources :users, only: %i[show] do
    member do
      get ':liked', to: 'users#show', as: :show
    end
  end

  resources :stocks, only: %i[index]
  resources :notifications, only: %i(index) do
    collection do
      patch :read_all, format: :js
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
