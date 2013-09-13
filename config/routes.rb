Railsplate::Application.routes.draw do
  root to: 'home#index'

  resources :patients

  resources :doctors
  namespace :doctors do
    get ":id/patients" => "patients#index", as: :patients
    get ":id/patients/new/:invite_id" => "patients#new", as: :new_patient
  end

  resources :sessions
  resources :password_resets
  resources :invites, :only => [:create, :new]
    get 'invites/:id/switch' => "invites#switch", as: :invites_switch
    get 'invites/:id/accept-and-register' => "invites#accept_and_register", as: :invite_accept_and_register
end
