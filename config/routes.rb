Rails.application.routes.draw do
  root 'queries#new'
  post '/lookup', to: 'queries#lookup', defaults: { format: :json }
  resources :queries, only: :new
  post '/queries', to: 'queries#lookup'
end
