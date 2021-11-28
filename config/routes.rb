Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api' do
    #get "/shifts", to: "shifts#index"
    #post "/shifts", to: "shifts#create"
    #get "/shifts/user", to: "shifts#my_shifts"
    #get "/shifts/:id", to: "shifts#show"
    #put "/shifts/:id", to: "shifts#update"
    #delete "/shifts/:id", to: "shifts#destroy"
    scope '/auth' do
      post "/sign-up", to: "users#create"
      post "/sign-in", to: "users#sign_in"
      post "/forgot-pass", to: "users#forgot_pass"
      post "/reset-pass", to: "users#reset_pass"
    end
  end  
end
