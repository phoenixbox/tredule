Railsplate::Application.routes.draw do
  root to: 'home#index'

  resources :patients

  resources :doctors
  namespace :doctors do
    get ":id/patients" => "patients#index", as: :patients
  end

  resources :sessions
  resources :password_resets
  resources :invites, :only => [:create]
end
