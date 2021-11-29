Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api' do
    scope '/organization' do
      get "/get", to: "organizations#index"
      post "/joined", to: "organizations#joined"
      post "/new", to: "organizations#create"
      #get "/shifts/user", to: "shifts#my_shifts"
      get "/view/:org_id", to: "organizations#show"
      post "/join", to: "organizations#join"
      delete "/leave/:org_id", to: "organizations#leave"
      put "/", to: "organizations#update"
      delete "/:org_id", to: "organizations#destroy"
    end
    scope '/shift' do
      post "/new", to: "shifts#create"
      get "/:org_id", to: "shifts#index"
    end
    scope '/auth' do
      post "/sign-up", to: "users#create"
      post "/sign-in", to: "users#sign_in"
      post "/forgot-pass", to: "users#forgot_pass"
      post "/reset-pass", to: "users#reset_pass"
    end
  end  
end
