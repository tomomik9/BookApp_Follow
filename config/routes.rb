Rails.application.routes.draw do
  get 'friendships/create'
  get 'friendships/destroy'
  resources :books do
    resources :comments, only: [:show, :create, :destroy, :edit, :update]
  end
  resources :reports do
    resources :comments, only: [:show, :create, :destroy, :edit, :update]
  end
  devise_for :users, :controllers => {
    :registrations => 'users/registrations', 
    :omniauth_callbacks => "users/omniauth_callbacks"
   }
  scope "(:locale)" do
    resources :books
  end
  scope "(:locale)" do
    resources :reports
  end
  scope "(:locale)" do
    resources :users
  end
  resources :follows 
  resources :followers
  resources :friendships, only: [:create, :destroy]
  resources :follows, only: [:show]
  resources :followers, only: [:show]
  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
