Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles, only: %i[index show new create edit update] do
    collection do
      post :preview
    end
    resources :stocks, only: %i[index create destroy]
    resources :likes, only: %i[create destroy], format: :js
    resources :comments, only: %i[create update]
  end

  devise_for :users

  resources :users, only: %i[show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
