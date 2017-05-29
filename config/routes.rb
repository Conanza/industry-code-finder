Rails.application.routes.draw do
  root 'queries#test', as: 'home'
  post '/queries', to: 'queries#test2'
end
