Rails.application.routes.draw do
  get 'permissions/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users do
    get 'search', on: :collection
    post 'search', on: :collection
    get 'access', on: :member
    post 'empower', on: :member
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :actions, only: [:index]
  resources :resources, only: [:new, :create, :index]
  resources :permissions, only: [:index] do
    post 'search', on: :collection
  end
  resources :roles, only: [:new, :create, :index, :edit, :update] do
    get 'access', on: :member
    post 'empower', on: :member
  end
end
