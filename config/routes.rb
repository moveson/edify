require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  draw :madmin
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"

    namespace :madmin do
      resources :impersonates do
        post :impersonate, on: :member
        post :stop_impersonating, on: :collection
      end
    end
  end

  resources :access_requests
  resources :announcements, only: [:index]
  resources :meetings do
    post :upsert, on: :collection
    resources :talks, except: :index do
      post :upsert, on: :collection
    end
  end
  resources :members do
    post :upsert, on: :collection
    resources :notes
  end
  resources :notifications, only: [:index]
  resources :talks, only: [:index]
  resources :units, only: [:edit, :create, :update]

  devise_for :users, controllers: { sessions: "users/sessions" }
  root to: "home#index"
  get "/privacy", to: "home#privacy"
  get "/terms", to: "home#terms"
  get "/onboard", to: "onboard#start"
  get "/onboard_request_access", to: "onboard#request_access"
  post "/onboard_submit_request", to: "onboard#submit_request"
  get "/onboard_new_ward", to: "onboard#new_ward"
end
