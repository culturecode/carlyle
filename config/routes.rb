Rails.application.routes.draw do
  root 'pages#home'

  resources :documents, :only => [:index, :show]

  namespace :admin do
    resources :documents
  end

  get 'pages/:action', :controller => :pages
end
