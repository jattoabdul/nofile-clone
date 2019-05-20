Rails.application.routes.draw do
  devise_for :users
  resources :uploads

  get '/:id' => "shortener/shortened_urls#show"

  root to: 'uploads#new', via: :all
end
