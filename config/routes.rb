Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'login#create'

      resources :urls, only: %i[create show destroy]
      resources :users, only: %i[show], param: :username
    end
  end
end
