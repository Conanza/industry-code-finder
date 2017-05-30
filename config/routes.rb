Rails.application.routes.draw do
  root 'queries#test'
  post '/lookup', to: 'queries#lookup', defaults: { format: :json }
end
