require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  draw :madmin
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }

  resources :access_requests, only: [:new, :create, :destroy] do
    get :review, on: :member
    put :approve, on: :member
    put :reject, on: :member
  end
  resources :announcements, only: [:index]
  resources :import_jobs, only: [:index, :show, :new, :create, :destroy]
  resources :meetings do
    post :upsert, on: :collection
    resources :talks, except: :index do
      patch :move, on: :member
      post :upsert, on: :collection
    end
  end
  resources :members do
    post :upsert, on: :collection
    resources :notes
  end
  resources :notifications, only: [:index]
  resources :talks, only: [:index]
  resources :units, only: [:new, :edit, :create, :update]
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  namespace :settings do
    get :preferences
    get :avatar
    get :password
    put :update
    put :remove_avatar
  end

  root to: "home#index"
  get "/privacy", to: "home#privacy"
  get "/terms", to: "home#terms"
  get "/onboard", to: "onboard#start"
  post "impersonate/start/:id", to: "impersonate#start", as: "impersonate_start"
  post "impersonate/stop", to: "impersonate#stop", as: "impersonate_stop"
end
