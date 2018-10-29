Rails.application.routes.draw do
  root to: 'home#index'

  resources :articles, only: %i[index new create edit update] do
    resources :stocks, only: %i[index create destroy]
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create update]
  end

  devise_for :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
