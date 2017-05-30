Rails.application.routes.draw do
  post '/lookup', to: 'queries#lookup', defaults: { format: :json }
end
