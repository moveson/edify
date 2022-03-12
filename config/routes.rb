require "sidekiq/web"

Rails.application.routes.draw do

  draw :madmin
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"

    namespace :madmin do
      resources :impersonates do
        post :impersonate, on: :member
        post :stop_impersonating, on: :collection
      end
    end

    resources :members do
      post :import, on: :collection
    end

    resources :talks
    resources :notifications, only: [:index]
    resources :announcements, only: [:index]
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "home#index"
  get "/privacy", to: "home#privacy"
  get "/terms", to: "home#terms"
end
