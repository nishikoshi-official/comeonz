Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }


  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
