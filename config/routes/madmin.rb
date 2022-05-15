# Below are the routes for madmin
namespace :madmin do
  resources :import_jobs
  resources :notifications
  resources :units
  resources :meetings
  resources :talks
  resources :members
  resources :announcements
  resources :users
  namespace :active_storage do
    resources :blobs
  end
  namespace :active_storage do
    resources :variant_records
  end
  namespace :active_storage do
    resources :attachments
  end
  root to: "dashboard#show"
end
