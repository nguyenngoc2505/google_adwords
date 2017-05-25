require "sidekiq/web"
Rails.application.routes.draw do
  root "keywords#index"
  devise_for :users
  resources :keywords, only: [:index, :create, :show]

  mount Sidekiq::Web, at: "/google_adword_sidekiq"

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post "/login" => "sessions#create"
      get "/logout" => "sessions#destroy"
    end

    resources :keywords, only: [:index, :create, :show]
  end
end
