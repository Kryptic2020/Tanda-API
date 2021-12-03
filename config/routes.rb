Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "users#index", as:"index"
  scope '/api' do
    scope '/organization' do
      get "/get", to: "organizations#index"
      post "/joined", to: "organizations#joined"
      post "/new", to: "organizations#create"
      put "/" , to: "organizations#update"
      get "/view/:org_id", to: "organizations#show"
      post "/join", to: "organizations#join"
      delete "/leave/:org_id", to: "organizations#leave"
      delete "/:org_id", to: "organizations#destroy"
    end
    scope '/shift' do
      post "/new", to: "shifts#create"
      put "/update", to: "shifts#update"
      put "/break/update", to: "shifts#break_update"
      post "/shifts", to: "shifts#shifts"
      get "/show/:shift_id", to: "shifts#show"
      delete "/:shift_id", to: "shifts#destroy"
    end
    scope '/auth' do
      post "/current-user", to: "users#show"
      post "/sign-up", to: "users#create"
      post "/sign-in", to: "users#sign_in"
      put "/update", to: "users#update"
      post "/forgot-pass", to: "users#forgot_pass"
      post "/reset-pass", to: "users#reset_pass"
    end
  end  
end
