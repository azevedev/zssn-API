Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post "/survivor", to: "survivors#add_survivor"
      get "/survivor", to: "survivors#get_survivor"
      get "/survivors", to: "survivors#get_all_survivors"
      put "/survivor", to: "survivors#update_location"
    end
  end
end
