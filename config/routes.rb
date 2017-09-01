Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'welcome#index'

  resources :projects, only: [:index, :show]

  resources :users do
    resources :projects
  end
end
