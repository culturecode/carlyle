Rails.application.routes.draw do
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
