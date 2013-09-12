Railsplate::Application.routes.draw do
  root to: 'home#index'

  resources :patients

  resources :doctors
  namespace :doctors do
    get ":id/patients" => "patients#index", as: :patients
    get ":id/patients/new/:email" => "patients#new", as: :new_patient
  end

  resources :sessions
  resources :password_resets
  resources :invites, :only => [:create]
  get 'invites/:id/switch' => "invites#switch", as: :invites_switch
end
