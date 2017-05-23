Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  resources :keywords, only: [:index, :create]

  scope :api, defaults: {format: :json} do
    devise_scope :user do
      post "/login" => "api/sessions#create"
      get "/logout" => "api/sessions#destroy"
    end
  end
end
