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
    post 'invites/:id/signup' => "invites#signup", as: :invites_signup
    post 'invites/:id/login-and-associate' => "invites#login_and_associate", as: :invites_login_and_associate
    get 'invites/:id/sign_in' => "invites#new_session", as: :invites_new_session
    get 'invites/:id/create-and-associate' => "invites#create_and_associate", as: :invite_create_and_associate
end
