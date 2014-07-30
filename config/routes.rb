Rails.application.routes.draw do
  devise_for :users
  get 'owners/sign_in' => 'owner/sessions#new', :as => :new_owner_session
  post 'owners/sessions' => 'owner/sessions#create', :as => :owner_session

  root 'pages#home'

  resources :documents, :only => [:index, :show]

  namespace :admin do
    resources :documents
  end

  get 'gallery' => 'pages#gallery', :as => :gallery
  get 'floorplans' => 'pages#floorplans', :as => :floorplans
  get 'contact' => 'pages#contact', :as => :contact

  get 'pages/:action', :controller => :pages
end
