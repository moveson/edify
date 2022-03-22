# Below are the routes for madmin
namespace :madmin do
  resources :talks
  resources :members
  resources :announcements
  resources :services
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
