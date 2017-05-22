Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  devise_scope :user do
    post "/login" => "api/sessions#create"
  end
end
