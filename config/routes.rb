Rails.application.routes.draw do
  root "form#index"
  get "/form", to: "form#index"
  get "/encode", to: "form#encode"
  post "/create", to: "form#create"
  post "/change", to: "form#change"
end
