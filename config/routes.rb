Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles, only: %i[index show new create edit update] do
    collection do
      post :preview
    end
    resources :stocks, only: %i[create destroy], format: :js
    resources :likes, only: %i[create destroy], format: :js
    resources :comments, only: %i[create update]
  end

  devise_for :users

  resources :users, only: %i[show] do
    member do
      get '(:liked)', to: 'users#show', as: :show
    end
  end

  resources :stocks, only: %i[index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
