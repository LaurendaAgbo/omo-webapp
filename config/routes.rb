Rails.application.routes.draw do
  # mount_devise_token_auth_for 'Admin', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # standard devise routes available at /users
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
    confirmations: 'admins/confirmations',
    unlocks: 'admins/unlocks',
    invitations: 'admins/invitations'
  }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }  
end
