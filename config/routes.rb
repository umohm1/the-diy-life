Rails.application.routes.draw do

  resources :user_projects
  resources :projects
  #resources :users, only: [:show]
  root 'welcome#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


end
