Elovation::Application.routes.draw do
  resources :games do
    resources :results, only: [:create, :destroy, :new]
    resources :ratings, only: [:index]
  end

  resources :players do
    resources :games, only: [:show], controller: 'player_games'
  end

  get '/login' => 'auth#login', as: 'login'
  get '/auth/:vendor/callback' => 'auth#callback'
  delete '/logout' => 'auth#logout', as: 'logout'

  get '/dashboard' => 'dashboard#show', as: :dashboard
  root to: 'dashboard#show'
end
