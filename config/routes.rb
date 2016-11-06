Rails.application.routes.draw do
  root 'home#index'
  as :user do
    root 'bills#index'
  end

  resources :bills, only: [:index]

  devise_for :users, path: '', path_names: { sign_in: 'sign-in' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
