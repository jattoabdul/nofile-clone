Rails.application.routes.draw do
  devise_for :users
  resources :uploads

  root to: 'uploads#new', via: :all
end
