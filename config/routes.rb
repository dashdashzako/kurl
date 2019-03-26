Rails.application.routes.draw do
  resources :urls, constraints: { format: 'json' }
end
