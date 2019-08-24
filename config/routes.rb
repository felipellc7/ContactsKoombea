Rails.application.routes.draw do
  post 'users/sign_up', to: 'users#sign_up'
  post 'users/sign_in', to: 'users#sign_in'
  post 'users/sign_out', to: 'users#sign_out'
  post 'profile', to: 'users#profile'
  put 'profile', to: 'users#update_profile'
  resources :contacts
end
