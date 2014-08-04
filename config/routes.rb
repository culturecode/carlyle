Rails.application.routes.draw do
  devise_for :users, :path => 'admin'
  get 'owners/sign_in' => 'owner/sessions#new', :as => :new_owner_session
  post 'owners/sessions' => 'owner/sessions#create', :as => :owner_session

  namespace :admin do
    root 'documents#index'
    resources :documents
  end

  namespace :owner do
    root 'documents#index'
    resources :documents
  end

  root 'pages#home'
  resources :documents, :only => [:index, :show]


  # GENERIC PAGES

  get 'gallery' => 'pages#gallery', :as => :gallery
  get 'floorplans' => 'pages#floorplans', :as => :floorplans
  get 'contact' => 'pages#contact', :as => :contact

  get 'pages/:action', :controller => :pages
end
