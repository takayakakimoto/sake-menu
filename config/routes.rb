Rails.application.routes.draw do
 root to: 'toppages#index'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
 
 get 'signup', to: 'users#new'
 resources :users 
 resources :sakes, only: [:show, :new]
 resources :relationships, only: [:create, :destroy]
 resources :ownerships, only: [:create, :destroy]
end
