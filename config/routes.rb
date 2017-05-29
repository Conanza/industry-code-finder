Rails.application.routes.draw do
  root 'queries#test'
  post '/queries', to: 'queries#test2'
end
