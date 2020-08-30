Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :survivors
      put "/survivor/:id/location", to: "survivors#update_location", as: :location
      post "/trades", to: "trades#create"
      resources :reports
      get "/status", to: 'status#status'

    end
  end
end
