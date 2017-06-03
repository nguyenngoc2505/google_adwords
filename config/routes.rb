require "sidekiq/web"
Rails.application.routes.draw do
  root "keywords#index"
  devise_for :users
  resources :keywords, only: [:index, :show]
  resources :import_keywords, only: :create

  mount Sidekiq::Web, at: "/google_adword_sidekiq"

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post "/login" => "sessions#create"
      get "/logout" => "sessions#destroy"
    end

    resources :keywords, only: [:index, :show]
    resources :import_keywords, only: :create
  end
end
