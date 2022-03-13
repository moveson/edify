require "sidekiq/web"

Rails.application.routes.draw do
  resources :import_jobs

  draw :madmin
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"

    namespace :madmin do
      resources :impersonates do
        post :impersonate, on: :member
        post :stop_impersonating, on: :collection
      end
    end

    resources :announcements, only: [:index]
    resources :import_jobs, only: [:index, :show, :new, :create, :destroy]
    resources :members
    resources :notifications, only: [:index]
    resources :talks
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "home#index"
  get "/privacy", to: "home#privacy"
  get "/terms", to: "home#terms"
end
